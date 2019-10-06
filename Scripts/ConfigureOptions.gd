extends Node

onready var Lobby = get_tree().get_root().get_node('Lobby')

var game_speed = 0.4
var player_approaching_speed = 5.0
var enemy_approaching_speed = 5.0
var attack_speed = 3.0

func _ready():
    # #TODO: read config_fiel
    pass # Replace with function body.

func hide():
    $CenterContainer.hide()

func show():
    $CenterContainer.show()

func _on_game_speed_slider_value_changed(value):
    game_speed = value
    print('changed game_speed to', value)
    find_node("game_speed_label").text = "%1.1f" % [value]

func _on_player_approaching_speed_slider_value_changed(value):
    player_approaching_speed = value
    print('changed _on_player_approaching_speed_slider_value_changed to', value)
    find_node("player_approaching_speed_label").text = "%1.1f" % [value]

func _on_enemy_approaching_speed_slider_value_changed(value):
    enemy_approaching_speed = value
    print('changed _on_enemy_approaching_speed_slider_value_changed to', value)
    find_node("enemy_approaching_speed_label").text = "%1.1f" % [value]

func _on_attack_speed_slider_value_changed(value):
    attack_speed = value
    print('changed _on_attack_speed_slider_value_changed to', value)
    find_node("attack_speed_label").text = "%1.1f" % [value]

func _on_continue_button_pressed():
    print('save to file')
    Lobby.return_from_options()
