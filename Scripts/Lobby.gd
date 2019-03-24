extends Node

var card_scene = preload("res://Scenes/Card.tscn")
var game_scene = preload("res://Scenes/Game.tscn")
var deck_slot_scene = preload("res://Scenes/DeckSlot.tscn")

var speed_up = 0.8

#onready var enemy_difficulty = ButtomGroup

func card_names():
    var result = []
    for fun in cards.get_method_list():
        # all card definitions are defined in a script file (flags) and have exactly one argument
        if(fun["flags"] == METHOD_FLAG_FROM_SCRIPT+1 && fun["args"].size() == 1):
            result.append(fun["name"])
    return result

func deck_for_card_name(card_name):
    var temp_card = card_scene.instance()
    temp_card.become(card_name)
    if temp_card.deck == 'player':
        return find_node('player_deck_grid')
    else: if temp_card.deck == 'extra':
        return find_node('extra_deck_grid')
    else: if temp_card.deck == 'enemy':
        return find_node('enemy_deck_grid')

func _ready():
    update_speed_info()

    # setup cards
    for c_name in card_names():
        var deck_slot = deck_slot_scene.instance()
        var grid = deck_for_card_name(c_name)
        grid.add_child(deck_slot)
        deck_slot.set_card(c_name)

func update_speed_info():
    find_node('speed-info').text = "%1.1f" % [speed_up]

func _on_speedslider_value_changed(value):
    speed_up = value
    update_speed_info()

func deck_config(key):
    return find_node(key, true).pressed

func deck_list_from_grid(grid):
    var list = []
    
    for slot in grid.get_children():
        if slot.num_copies >= 1:
            list.append(slot.card_name)

    return utils.shuffle(list)

func player_deck_from_config(player_deck):
    player_deck.set_deck_list(lists.PLAYER_FIRST + deck_list_from_grid(find_node('player_deck_grid')))

# ---------------------------------------------------------------------------------------------

func enemy_deck_from_config(enemy_deck):
    enemy_deck.set_deck_list(lists.ENEMY_DECK)

# ---------------------------------------------------------------------------------------------

func extra_deck_from_config(extra_deck):
    extra_deck.set_deck_list(lists.EXTRA_DECK)

# ---------------------------------------------------------------------------------------------

func _on_play_button_pressed():
    var root = get_tree().get_root()
    var game = game_scene.instance()
    root.add_child(game)
    $CenterContainer.hide()
    $PanelContainer.hide()

func end_game():
    var root = get_tree().get_root()
    root.remove_child(root.get_node('Game'))
    $CenterContainer.show()
    $PanelContainer.show()
