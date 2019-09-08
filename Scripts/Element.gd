extends Node2D

#var element_scene = preload("res://Scenes/Element.tscn")

onready var Game = get_tree().get_root().get_node('Game')

var type = 'fire'

func get_element():
    return type

func set_element(t):
    type = t
    $sprite.frame = get_element_frame()

func get_element_frame():
    if type == 'fire': return 80
    if type == 'water': return 81
    if type == 'earth': return 82
    return 109
