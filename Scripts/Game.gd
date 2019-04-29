extends Node

var card_scene = preload("res://Scenes/Card.tscn")
var element_scene = preload("res://Scenes/Element.tscn")
var hint_scene = preload("res://Scenes/Damage_Number.tscn")
onready var Lobby = get_tree().get_root().get_node('Lobby')

var CARD_EXTENT_HALF = Vector2(128/2, 128/2)
#var ENEMY_IN_WAIT_POS = Vector2(860, 10) + CARD_EXTENT_HALF

var HAND_POS_START = Vector2(220, 460) + CARD_EXTENT_HALF
var HAND_POS_OFFSET = Vector2(150, 0)
var COMBO_CARD_POS = Vector2(45, 460) + CARD_EXTENT_HALF

var ELEMENT_SEQUENCE_HAVE_POS_START = Vector2(30, 320)
var ELEMENT_SEQUENCE_GOAL_POS_START = Vector2(30, 350)
var ELEMENT_SEQUENCE_GOAL_POS_OFFSET = Vector2(24, 0)

var effect_store = {
    num_rats = 0
}

# ---------------------------------------------------------------------------------------------

func display_hint(target, message, color):
    $effects.add_child(hint_scene.instance().start(target, message, color))

func all_cards(condition):
    var result = []
    var card_names = Lobby.card_names()
    for card_name in card_names:
        var card = card_scene.instance()
        card.become(card_name)
        result.append(card)
    var filtered = utils.filter_props(result, condition)
    return utils.pluck(filtered, 'key')

func add_card(card):
    $cards.add_child(card)

func create_card(pos=Vector2(100, 100)):
    var card = card_scene.instance()
    card.set_name("card")
    card.add_to_group('card')
    card.position = pos
    add_card(card)
    return card

func create_card_by_name(pos, name, side):
    var card = create_card(pos)
    card.add_to_group(side)
    card.become(name)

    return card

func create_card_from_deck():
    return $player_deck.create_next_card()

func create_card_from_enemy_deck():
    return $enemy_deck.create_next_card()

func create_card_from_extra_deck():
    pass
    #return $extra_deck.create_next_card()

func draw_a_card():
    var card = create_card_from_deck()
    card.add_to_hand()
    return card

func cards_in_player_hand():
    return utils.get_nodes_in_groups(['hand', 'friendly'])

func discard_player_hand():
    var hand = cards_in_player_hand()
    for card in hand:
        card.discard()

func discard_leftmost_card():
    var hand = cards_in_player_hand()
    if not hand.empty():
        var leftmost_card = hand[0]
        leftmost_card.discard()

func _ready():
    $"win-lose-box".hide()
    
    Lobby.set_deck_from_config($player_deck, 'player')
    Lobby.set_deck_from_config($enemy_deck, 'enemy')

    $towers/tower_right_enemy.add_to_field($field/field_right_enemy_tower)
    $towers/tower_right_ally.add_to_field($field/field_right_ally_tower)
    $towers/tower_middle_enemy.add_to_field($field/field_middle_enemy_tower)
    $towers/tower_middle_ally.add_to_field($field/field_middle_ally_tower)
    $towers/tower_left_enemy.add_to_field($field/field_left_enemy_tower)
    $towers/tower_left_ally.add_to_field($field/field_left_ally_tower)
    
    draw_a_card()
    draw_a_card()

func organize_hand():
    var index = 0
    var cards_in_hand = get_tree().get_nodes_in_group("hand")
    for c in cards_in_hand:
        if not c.is_in_group('drag'):
            c.go_to(HAND_POS_START + index * HAND_POS_OFFSET, 2.0)
        index += 1

func organize_enchantment():
    var ENCHANTMENT_POS_START = Vector2(45, 50) + CARD_EXTENT_HALF
    var ENCHANTMENT_POS_OFFSET = Vector2(0, 150)
    var index = 0
    var active_enchantments = get_tree().get_nodes_in_group("active_enchantment")
    for card in active_enchantments:
        card.go_to(ENCHANTMENT_POS_START + index * ENCHANTMENT_POS_OFFSET, 2.0)
        index += 1

func get_approaching_cards():
    return utils.get_nodes_in_groups(["approaching", "friendly"])

func get_approaching_card():
    var approaching_cards = get_approaching_cards()
    if approaching_cards.size() >= 1:
        return approaching_cards[0]
    else:
        return null

func has_approaching_card():
    return get_approaching_cards().size() >= 1

func create_approaching_card():
    var approaching_card = create_card_from_deck()
    approaching_card.add_to_group("approaching")
    approaching_card.start_timer(5, "draw_approaching_card", "draw")
    
func refill_approaching_card_player():
    if not has_approaching_card():
        create_approaching_card()

func ensure_approaching_card_player():
    refill_approaching_card_player()
    return get_approaching_card()

# enemy approaching and in-wait cards
# ---------------------------------------------------------------------------------------------

func in_wait_cards():
    return utils.get_nodes_in_groups(["in_wait", "enemy"])

func refill_in_wait_card_enemy():
    if in_wait_cards().empty():
        var card = create_card_from_enemy_deck()
        card.add_to_group("in_wait")

func get_in_wait_card_enemy():
    var cards = in_wait_cards()
    if cards.size() >= 1:
        return cards[0]
    else:
        return null

func ensure_in_wait_card_enemy():
    refill_in_wait_card_enemy()
    return get_in_wait_card_enemy()

func enemy_approaching_cards():
    return utils.get_nodes_in_groups(["approaching", "enemy"])

func get_approaching_card_enemy():
    var approaching_cards = enemy_approaching_cards()
    if approaching_cards.size() >= 1:
        return approaching_cards[0]
    else:
        return null

func has_approaching_card_enemy():
    return enemy_approaching_cards().size() >= 1

func in_wait_to_approaching_enemy_card(card):
    card.go_to($back_enemy_approaching.rect_position + CARD_EXTENT_HALF)
    
    card.remove_from_group("in_wait")
    card.add_to_group("approaching")
    
    card.start_timer(5, "play_enemy_card", "play")

func create_approaching_card_enemy():
    var approaching_card = ensure_in_wait_card_enemy()
    in_wait_to_approaching_enemy_card(approaching_card)
    
func refill_approaching_card_enemy():
    if not has_approaching_card_enemy():
        create_approaching_card_enemy()

func ensure_approaching_card_enemy():
    refill_approaching_card_enemy()
    return get_approaching_card_enemy()

# process & game end
# ---------------------------------------------------------------------------------------------

func _process(delta):
    refill_approaching_card_player()
    refill_approaching_card_enemy()
    ensure_in_wait_card_enemy()

func check_game_end():
    if $"win-lose-box".is_visible(): return
    
    var enemy_towers = [$towers/tower_left_enemy, $towers/tower_middle_enemy, $towers/tower_right_enemy]
    var ally_towers = [$towers/tower_left_ally, $towers/tower_middle_ally, $towers/tower_right_ally]
    
    var win = utils.filter_func(enemy_towers, 'is_destroyed', true).size() >= 2
    var lose = utils.filter_func(ally_towers, 'is_destroyed', true).size() >= 2
    
    if win or lose:
        $"win-lose-box".show()
        if lose:
            var message = $"win-lose-box".find_node('message')
            message.text = 'You Lose!'
            message.set("custom_colors/font_color", Color(1,0,0))

# querying
# ---------------------------------------------------------------------------------------------

func fields():
    return $field.get_children()

func get_hovered_field():
    for field in fields():
        if field.is_hovered():
            return field

func enemy_familiar_fields():
    return utils.filter_props(fields(), {side = 'enemy', type = 'familiar'})

func unoccupied_enemy_familiar_fields():
    return utils.filter_func(enemy_familiar_fields(), 'is_empty', true)

func occupied_enemy_familiar_fields():
    return utils.filter_func(enemy_familiar_fields(), 'is_empty', false)

func enemy_familiars():
    return utils.pluck(occupied_enemy_familiar_fields(), 'card')

func enemy_towers():
    var tower_fields = utils.filter_props(fields(), {side = 'enemy', type = 'tower'})
    return utils.pluck(tower_fields, 'tower')

func friendly_familiar_fields():
    return utils.filter_props(fields(), {side = 'friendly', type = 'familiar'})

func unoccupied_friendly_familiar_fields():
    return utils.filter_func(friendly_familiar_fields(), 'is_empty', true)

func occupied_friendly_familiar_fields():
    return utils.filter_func(friendly_familiar_fields(), 'is_empty', false)

func friendly_familiars():
    return utils.pluck(occupied_friendly_familiar_fields(), 'card')

func familiars_on_field():
    var familiar_fields = utils.filter_props(fields(), {type = 'familiar'})
    var result = []
    for f in familiar_fields:
        if f.card:
            result.append(f.card)
    return result

# events
# ---------------------------------------------------------------------------------------------

func cards():
    return get_tree().get_nodes_in_group('card')

func event():
    pass #TODO#TODO#TODO

func executed_event(name, arg):
    for card in cards():
        card.exec_whenever(name, arg)

# comboing
# ---------------------------------------------------------------------------------------------

func make_combo_card(name):
    for card in get_tree().get_nodes_in_group('combo'):
        card.queue_free()
    var card = create_card(COMBO_CARD_POS)
    card.add_to_group("friendly")
    card.add_to_group("combo")

    card.become(name)
    card.start_timer(3, "remove_combo_card", "combo")

func has_combo_card():
    return not get_tree().get_nodes_in_group('combo').empty()
    
func get_combo_card():
    return get_tree().get_nodes_in_group('combo')[0]
    
# playing cards
# ---------------------------------------------------------------------------------------------

func try_to_play_card(card):
    var field = get_hovered_field()
    if card.check_targeting(field):
        card.remove_from_hand()
        card.play_ally(field)

func try_to_play_enemy_card(card):
    var target_field = card.exec_enemy_ai()
    
    if not target_field:
        return false
    
    card.play_enemy(target_field)
    return true

# ---------------------------------------------------------------------------------------------

func _on_returnbutton_pressed():
    Lobby.end_game()
