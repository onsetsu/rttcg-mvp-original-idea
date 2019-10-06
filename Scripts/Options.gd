extends Node

onready var Lobby = get_tree().get_root().get_node('Lobby')

var game_speed = 0.4
var player_approaching_speed = 5.0
var enemy_approaching_speed = 5.0
var attack_speed = 3.0

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass


func _on_game_speed_slider_value_changed(value):
    pass # Replace with function body.


func _on_player_approaching_speed_slider_value_changed(value):
    pass # Replace with function body.


func _on_enemy_approaching_speed_slider_value_changed(value):
    pass # Replace with function body.


func _on_attack_speed_slider_value_changed(value):
    pass # Replace with function body.


func _on_continue_button_pressed():
    pass # Replace with function body.
