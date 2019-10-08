extends Node

var card_scene = preload("res://Scenes/Card.tscn")
var card_images_scene = preload("res://Scenes/CardImages.tscn")
onready var card_images = card_images_scene.instance()
var game_scene = preload("res://Scenes/Game.tscn")
var deck_slot_scene = preload("res://Scenes/DeckSlot.tscn")
var card_reward_scene = preload("res://Scenes/CardReward.tscn")
var configure_options_scene = preload("res://Scenes/ConfigureOptions.tscn")

# handling options in dedicated scene
var speed_pause_modifier = 1.0

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
    scene_stack.init(self)

    # setup cards
    for c_name in card_names():
        var deck_slot = deck_slot_scene.instance()
        var grid = deck_for_card_name(c_name)
        grid.add_child(deck_slot)
        deck_slot.set_card(c_name)

    apply_last_decks()

func _process(delta):
    update_speed_info()

    if Input.is_action_just_pressed("pause"):
        if speed_pause_modifier == 0.0:
            speed_pause_modifier = 1.0
        else:
            speed_pause_modifier = 0.0

func update_speed_info():
    find_node('speed-info').text = "%1.1f" % [options.game_speed]
    find_node('speed-slider').value = options.game_speed

func _on_speedslider_value_changed(value):
    options.game_speed = value

func deck_config(key):
    return find_node(key, true).pressed

func deck_slot_compare(slotA, slotB):
    if slotA.get_num_copies() == slotB.get_num_copies():
        return slotA.card_name > slotB.card_name
    else:
        return slotA.get_num_copies() < slotB.get_num_copies()
func sort_grid(type):
    var grid = grid_for_type(type)
    var slots = [] + grid.get_children()
    slots.sort_custom(self, "deck_slot_compare")
    slots.invert()
    for idx in range(slots.size()):
        grid.move_child(slots[idx], idx)
func sort_grids():
    sort_grid('player')
    sort_grid('enemy')

func dict_to_grid(dict, type):
    var grid = grid_for_type(type)

    for slot in grid.get_children():
        var num_copies = utils.get_or_create(dict, slot.card_name, 0)
        slot.set_num_copies(num_copies)

func dict_for_type(type):
    return grid_to_dict(grid_for_type(type))

func inc_amount_in_grid(key):
    var grid = grid_for_type('player')
    var slot = utils.find_props(grid.get_children(), { card_name = key })
    if slot:
        slot.num_copies += 1
    else:
        print('did not find the card [' + key + ']. Could not increment.')

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

# Saving/Loading facilities for decks
# ---------------------------------------------------------------------------------------------

func file_name_deck_player_custom(): return "user://player_custom.deck"
func file_name_deck_player_last(): return "user://player_last.deck"
func file_name_deck_enemy_custom(): return "user://enemy_custom.deck"
func file_name_deck_enemy_last(): return "user://enemy_last.deck"

func init_default_deck(file_name):
    var default_deck = {}
    if file_name.match('*player*'):
        default_deck = _player_default_deck()
    else: if file_name.match('*enemy*'):
        default_deck = _enemy_deck_default()
    save_deck(file_name, default_deck)

func load_deck(file_name):
    var deck_file = File.new()
    if not deck_file.file_exists(file_name):
        init_default_deck(file_name)
    deck_file.open(file_name, File.READ)
    var dict = parse_json(deck_file.get_as_text())
    deck_file.close()
    return dict

func save_deck(file_name, dict):
    var save_deck = File.new()
    save_deck.open(file_name, File.WRITE)
    save_deck.store_string(to_json(dict))
    save_deck.close()

# ---------------------------------------------------------------------------------------------

func save_as_last_decks():
    save_deck(file_name_deck_player_last(), dict_for_type('player'))
    save_deck(file_name_deck_enemy_last(), dict_for_type('enemy'))

func apply_last_decks():
    var last_player_deck = load_deck(file_name_deck_player_last())
    var last_enemy_deck = load_deck(file_name_deck_enemy_last())

    dict_to_grid(last_player_deck, 'player')
    dict_to_grid(last_enemy_deck, 'enemy')

    sort_grids()

# Game START and END
# ---------------------------------------------------------------------------------------------

func _on_play_button_pressed():
    save_as_last_decks()
    instance_and_push(game_scene)

# Button Callbacks
# ---------------------------------------------------------------------------------------------

func _player_default_deck():
    return {
        "Adventurer" : 2,
        "Duelist" : 1,
        "IceWall" : 1,
        "Fireball" : 1,
        "PowerPotion" : 1,
        "FormOfDragon" : 1,
        "Scout" : 1,
    }
func _on_RookieParty_pressed():
    dict_to_grid(_player_default_deck(), 'player')
    sort_grid('player')

func _on_LordsOfTheArena_pressed():
    dict_to_grid({
        "Adventurer" : 1,
        "BattleBot" : 1,
        "BladeDance" : 1,
        "BuyARound" : 1,
        #"CuriousExperimenter" : 1,
        "HiredArm" : 1,
        "LoneChampion" : 1,
        "Scout" : 1,
        "Smash" : 1,
        "ToKu" : 1,
    }, 'player')
    sort_grid('player')

func __unused__():
    dict_to_grid({
        "BladeDance" : 1,
        "Arcanist" : 1,
        "Concentrate" : 1,
        "Duelist" : 1,
        "KnifeJuggler" : 1,
        "AsuraPriest" : 1,
        "SharedGrowth" : 1,
        "ComboFighter" : 1,
        "QuickBlast" : 1,
        "CreativeBurst" : 1,
        "Well" : 1,
        "ChargedBolt" : 1,
        "ChargedGrowth" : 1,
        "FlashForward": 1,
    }, 'player')
    sort_grid('player')

func _on_LoadCustomPlayer_pressed():
    var last_player_deck = load_deck(file_name_deck_player_custom())
    dict_to_grid(last_player_deck, 'player')
    sort_grid('player')

func _on_SaveCustomPlayer_pressed():
    save_deck(file_name_deck_player_custom(), dict_for_type('player'))
    sort_grid('player')

func _enemy_deck_default():
    return {
        "Skeleton" : 2,
        "Cultist" : 1,
        "SkeletonElite" : 1,
        "SewerDweller": 1,
        "Crawler": 1,
    }
func _on_DarkCultists_pressed():
    dict_to_grid(_enemy_deck_default(), 'enemy')
    sort_grid('enemy')

func _on_ForestWildlife_pressed():
    dict_to_grid({
        "FlyingBoar" : 1,
        "Juggernaut" : 1,
        "PackWolf" : 1,
        "ScytheCrawler" : 1,
        "SpiderKing" : 1,
        "StoneGiant" : 1,
    }, 'enemy')
    sort_grid('enemy')

func _on_EndlessWall_pressed():
    dict_to_grid({
        "SpikedWall" : 1,
        'Rampart': 1,
        'IceWallEnemy': 1,
        'WatchTower': 1,
        'AwakeTheWalls': 1
    }, 'enemy')
    sort_grid('enemy')

func _on_LoadCustomEnemy_pressed():
    var enemy_deck = load_deck(file_name_deck_enemy_custom())
    dict_to_grid(enemy_deck, 'enemy')
    sort_grid('enemy')

func _on_SaveCustomEnemy_pressed():
    save_deck(file_name_deck_enemy_custom(), dict_for_type('enemy'))
    sort_grid('enemy')


func _on_test_card_reward_pressed():
    instance_and_push(card_reward_scene)

func _on_options_button_pressed():
    instance_and_push(configure_options_scene)

func instance_and_push(scene_class):
    var scene = utils.instance_into_root(scene_class)
    scene_stack.push(scene)

func ss_init():
    pass
func ss_resume():
    $menu.show()
func ss_suspend():
    $menu.hide()
func ss_end():
    pass
