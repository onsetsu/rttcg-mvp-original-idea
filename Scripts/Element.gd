extends Node2D

var element_scene = preload("res://Scenes/Element.tscn")

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

func go_to(target_position, then):
    $pos_tween.stop_all()
    
    if $pos_tween.is_connected('tween_completed', Game, then):
        $pos_tween.disconnect('tween_completed', Game, then)
    $pos_tween.connect('tween_completed', Game, then)

    $pos_tween.interpolate_property(self,
        'global_position',
        global_position,
        target_position,
        0.8,
        Tween.TRANS_QUART,
        Tween.EASE_OUT
    )
    $pos_tween.start()

func init_chain():
    var new_element = copy()
    var target_pos = Game.ELEMENT_SEQUENCE_HAVE_POS_START + Game.ELEMENT_SEQUENCE_GOAL_POS_OFFSET * get_tree().get_nodes_in_group('element_sequence').size()
    new_element.add_to_group('element_sequence')
    new_element.go_to(target_pos, 'check_sequence')

func copy():
    var new_element = element_scene.instance()

    new_element.set_element(get_element())
    new_element.global_position = global_position
    get_tree().get_root().get_node('Game').add_child(new_element)

    return new_element
