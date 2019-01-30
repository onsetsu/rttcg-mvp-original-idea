extends Node

var card_scene = preload("res://Scenes/Card.tscn")
var element_scene = preload("res://Scenes/Element.tscn")

var CARD_EXTENT_HALF = Vector2(128/2, 128/2)
#var ENEMY_IN_WAIT_POS = Vector2(860, 10) + CARD_EXTENT_HALF

var HAND_POS_START = Vector2(220, 460) + CARD_EXTENT_HALF
var HAND_POS_OFFSET = Vector2(150, 0)
var COMBO_CARD_POS = Vector2(50, 170) + CARD_EXTENT_HALF

var ELEMENT_SEQUENCE_HAVE_POS_START = Vector2(30, 320)
var ELEMENT_SEQUENCE_GOAL_POS_START = Vector2(30, 350)
var ELEMENT_SEQUENCE_GOAL_POS_OFFSET = Vector2(24, 0)

var mana = 0
export var mana_delay = 1.75
export var mana_generation = 1

onready var DECK = [
    'VolJin',
    'Retreat',
    'Bomber',
    'CarnivorousOoze',
    'Cinderstorm',
    'PillarOfFire',
    'ElvenArcher',
    'Phoenix',
    'Blacksmith',
    'IdolOfBlades',
    'IdolOfGrowth',
    'Scout',
    'TheShepherd',
    'IdolOfSpeed',
    'IdolOfMirror',
    'IdolOfDragon',
    'DracoKnight',
    'FormOfDragon',
    'Flamekin',
    'MoonRabbit',
    'Multiply',
    'Bard',
    'SplittingOoze',
    'PierceThrough',
    'ComboFighter',
    'GoblinForerunner',
    'GiantGrowth',
    'SharedGrowth',
    'AsuraPriest',
    'Bumerang',
    'KnifeJuggler',
    'BladeDance',
    'GoblinLooter',
    'Anafenza',
    'Raid',
    'Dragon',
    'Flamekin',
    'Fireball',
    'Pyrokinesis',
    'IceWall',
]

onready var ENEMY_DECK = [
    'Goblin',
    'Juggernaut',
    'ManaSapling',
    'BatteringRam',
    'SiegeTower',
    'RockThrow',
    'Kirin',
    'Counterspell',
    'Goblin',
    'Hobgoblin',
    'Halberd',
    'RareHunter',
    'BearTrap',
]

onready var EXTRA_DECK = [
    'QuickForge',
    'Dethrone',
    'Duplicate',
    'BraveCharge',
]

# ---------------------------------------------------------------------------------------------

func create_card(pos=Vector2(100, 100)):
    var card = card_scene.instance()
    card.set_name("card")
    card.add_to_group('card')
    card.position = pos
    add_child(card)
    return card

func apply_onto(card, name):
    funcref(cards, name).call_func(card)

func create_card_by_name(pos, name, side):
    var card = create_card(pos)
    card.add_to_group(side)

    apply_onto(card, name)

    return card

func create_card_from_deck():
    return $player_deck.create_next_card()

func create_card_from_enemy_deck():
    return $enemy_deck.create_next_card()

func create_card_from_extra_deck():
    return $extra_deck.create_next_card()

func draw_a_card():
    var card = create_card_from_deck()
    card.add_to_hand()

func _ready():
    $towers/tower_right_enemy.add_to_field($field/field_right_enemy_tower)
    $towers/tower_right_ally.add_to_field($field/field_right_ally_tower)
    $towers/tower_middle_enemy.add_to_field($field/field_middle_enemy_tower)
    $towers/tower_middle_ally.add_to_field($field/field_middle_ally_tower)
    $towers/tower_left_enemy.add_to_field($field/field_left_enemy_tower)
    $towers/tower_left_ally.add_to_field($field/field_left_ally_tower)
    
    $mana/mana_timer.init('generate', mana_delay, self, 'generate_mana')
    restart_mana_timer()
    
    draw_a_card()
    draw_a_card()

func restart_mana_timer():
    $mana/mana_timer.reset()
    $mana/mana_timer.start()

func generate_mana(unused):
    mana += mana_generation
    restart_mana_timer()

func organize_hand():
    var index = 0
    var cards_in_hand = get_tree().get_nodes_in_group("hand")
    for c in cards_in_hand:
        if not c.is_in_group('drag'):
            c.go_to(HAND_POS_START + index * HAND_POS_OFFSET, 2.0)
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
    approaching_card.add_approaching_timer("draw_approaching_card", "draw")
    
func refill_approaching_card_player():
    if not has_approaching_card():
        create_approaching_card()

func has_approaching_card_enemy():
    return utils.get_nodes_in_groups(["approaching", "enemy"]).size() >= 1

func create_approaching_card_enemy():
    var approaching_card = create_card_from_enemy_deck()
    approaching_card.add_to_group("approaching")
    approaching_card.add_approaching_timer("play_enemy_card", "play")
    
func refill_approaching_card_enemy():
    if not has_approaching_card_enemy():
        create_approaching_card_enemy()

func has_lingering_extra_deck_card():
    return utils.get_nodes_in_groups(["lingering", "friendly"]).size() >= 1

func create_lingering_extra_deck_card():
    var approaching_card = create_card_from_extra_deck()
    approaching_card.add_to_group("lingering")
    
func refill_lingering_extra_deck_card():
    if not has_lingering_extra_deck_card():
        create_lingering_extra_deck_card()
        renew_element_sequence()

func renew_element_sequence():
    var lingering_card = get_tree().get_nodes_in_group('lingering')[0]
    var index = 0
    for e_string in lingering_card.element_sequence:
        var element = element_scene.instance()
        element.set_element(e_string)
        element.add_to_group('element_sequence_should')
        add_child(element)
        element.position = ELEMENT_SEQUENCE_GOAL_POS_START + index * ELEMENT_SEQUENCE_GOAL_POS_OFFSET
        index += 1

func _process(delta):
    refill_approaching_card_player()
    refill_approaching_card_enemy()
    refill_lingering_extra_deck_card()

    $mana/mana_label.text = str(mana)

# extra deck activation
# ---------------------------------------------------------------------------------------------

func check_sequence(unused, unused2):
    if matches_sequence():
        clear_element_sequences()
        play_extra_deck_card()

func matches_sequence():
    var have = utils.arr_copy(utils.pluck(get_tree().get_nodes_in_group('element_sequence'), 'type'))

    refill_lingering_extra_deck_card()
    var lingering_card = get_tree().get_nodes_in_group('lingering')[0]
    var should = utils.arr_copy(lingering_card.element_sequence)

    if have.size() < should.size():
        return false

    have.invert()
    should.invert()

    var index = 0
    for s in should:
        var h = have[index]
        index += 1
        if s != h:
            return false
    return true

func clear_element_sequences():
    for element in get_tree().get_nodes_in_group('element_sequence'):
        element.queue_free()

    for element in get_tree().get_nodes_in_group('element_sequence_should'):
        element.queue_free()

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

func event(name, arg):
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

    apply_onto(card, name)
    
    var timer = card.create_timer()
    timer.init("combo", 3, card, "remove_combo_card")
    timer.start()

func has_combo_card():
    return not get_tree().get_nodes_in_group('combo').empty()
    
func get_combo_card():
    return get_tree().get_nodes_in_group('combo')[0]
    
# playing cards
# ---------------------------------------------------------------------------------------------

func try_to_play_card(card):
    if card.cost > mana: return
    mana -= card.cost
    
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

func play_extra_deck_card():
    var lingering_card = get_tree().get_nodes_in_group('lingering')[0]
    lingering_card.play_extra()

