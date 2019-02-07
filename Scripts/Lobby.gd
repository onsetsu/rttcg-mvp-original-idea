extends Node

var game_scene = preload("res://Scenes/Game.tscn")

func _ready():
    # Called every time the node is added to the scene.
    # Initialization here
    pass
    # always include first
    # always include
    # battlecry
    # deathrottle
    # combo
    # insire
    
func player_deck_from_config():
    return [] + lists.PLAYER_DEFAULT

func enemy_deck_from_config():
    return [] + lists.ENEMY_DECK

func extra_deck_from_config():
    return [] + lists.EXTRA_DECK


func _on_play_button_pressed():
    var root = get_tree().get_root()
    var game = game_scene.instance()
    root.add_child(game)
