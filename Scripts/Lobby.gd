extends Node

var game_scene = preload("res://Scenes/Game.tscn")

#onready var enemy_difficulty = ButtomGroup

func deck_config(key):
    return find_node(key, true).pressed

func player_deck_from_config(player_deck):
    var list = []

    list += lists.PLAYER_DEFAULT

    if deck_config("simple"):
        list += lists.PLAYER_SIMPLE
    if deck_config("complex"):
        list += lists.PLAYER_COMPLEX
    if deck_config("battlecry"):
        list += lists.PLAYER_BATTLECRY
    if deck_config("deathrottle"):
        list += lists.PLAYER_DEATHROTTLE
    if deck_config("combo"):
        list += lists.PLAYER_COMBO
    if deck_config("inspire"):
        list += lists.PLAYER_INSPIRE
    if deck_config("approaching"):
        lists.PLAYER_APPROACHING
    if deck_config("sabotage"):
        lists.PLAYER_SABOTAGE
    if deck_config("position"):
        list += lists.PLAYER_POSITION
    if deck_config("ignition"):
        lists.PLAYER_IGNITION
    if deck_config("delayed"):
        list += lists.PLAYER_DELAYED

    player_deck.set_deck_list(lists.PLAYER_FIRST + utils.shuffle(list))

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
