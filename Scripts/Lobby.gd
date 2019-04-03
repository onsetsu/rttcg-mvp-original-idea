extends Node

var card_scene = preload("res://Scenes/Card.tscn")
var game_scene = preload("res://Scenes/Game.tscn")
var deck_slot_scene = preload("res://Scenes/DeckSlot.tscn")

var speed_up = 0.8

func card_names():
    var result = []
    for fun in cards.get_method_list():
        # all card definitions are defined in a script file (flags) and have exactly one argument
        if(fun["flags"] == METHOD_FLAG_FROM_SCRIPT+1 && fun["args"].size() == 1):
            result.append(fun["name"])
    return result

func grid_for_type(type):
    if type == 'player':
        return find_node('player_deck_grid')
    else: if type == 'enemy':
        return find_node('enemy_deck_grid')
    
func deck_for_card_name(card_name):
    var temp_card = card_scene.instance()
    temp_card.become(card_name)
    return grid_for_type(temp_card.deck)

func dict_name_for_card_name(card_name):
    var temp_card = card_scene.instance()
    temp_card.become(card_name)
    if temp_card.deck == 'player':
        return 'player_deck'
    else: if temp_card.deck == 'enemy':
        return 'enemy_deck'

func _ready():
    update_speed_info()

    var saved_decks = load_deck()
    
    # setup cards
    for c_name in card_names():
        var deck_slot = deck_slot_scene.instance()
        var grid = deck_for_card_name(c_name)
        grid.add_child(deck_slot)
        
        var num_copies = utils.get_or_create(saved_decks[dict_name_for_card_name(c_name)], c_name, 0)
        deck_slot.set_card(c_name, num_copies)

func update_speed_info():
    find_node('speed-info').text = "%1.1f" % [speed_up]

func _on_speedslider_value_changed(value):
    speed_up = value
    update_speed_info()

func deck_config(key):
    return find_node(key, true).pressed

func grid_to_dict(grid):
    var dict = {}
    
    for slot in grid.get_children():
        if slot.num_copies >= 1:
            dict[slot.card_name] = slot.num_copies

    return dict

func dict_to_list(dict):
    var list = []
    
    for key in dict.keys():
        var num_copies = dict[key]
        while num_copies > 0:
            list.append(key)
            num_copies -= 1
    
    return list

func deck_list_from_grid(grid):
    var dict = grid_to_dict(grid)
    var list = dict_to_list(dict)
    return utils.shuffle(list)

# type = {'player', 'enemy'}
func set_deck_from_config(deck, type):
    deck.set_deck_list(deck_list_from_grid(grid_for_type(type)))

# ---------------------------------------------------------------------------------------------

func init_default_deck():
    save_deck({
        "player_deck" : {
            "Flamekin" : 2,
            "Dragon" : 1,
        },
        "enemy_deck" : {
            "Goblin" : 1,
        },
    })

func save_deck(dict):
    var save_deck = File.new()
    save_deck.open("user://deck.save", File.WRITE)
    save_deck.store_string(to_json(dict))
    save_deck.close()

func save_decks():
    save_deck({
        "player_deck": grid_to_dict(grid_for_type('player')),
        "enemy_deck" : grid_to_dict(grid_for_type('enemy')),
    })

func load_deck():
    var save_deck = File.new()
    if not save_deck.file_exists("user://deck.save"):
        init_default_deck()
    save_deck.open("user://deck.save", File.READ)
    var dict = parse_json(save_deck.get_as_text())
    save_deck.close()
    return dict

# ---------------------------------------------------------------------------------------------

func _on_play_button_pressed():
    save_decks()
    
    var root = get_tree().get_root()
    var game = game_scene.instance()
    root.add_child(game)
    $PanelContainer.hide()

func end_game():
    var root = get_tree().get_root()
    root.remove_child(root.get_node('Game'))
    $PanelContainer.show()
