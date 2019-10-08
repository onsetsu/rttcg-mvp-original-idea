extends Node

onready var Lobby = get_tree().get_root().get_node('Lobby')

func _ready():
    update_view()

func hide():
    $CenterContainer.hide()

func show():
    $CenterContainer.show()

func update_view():
    find_node("game_speed_label").text = "%1.1f" % [options.game_speed]
    find_node("game_speed_slider").value = options.game_speed
    find_node("player_approaching_speed_label").text = "%1.1f" % [options.player_approaching_speed]
    find_node("player_approaching_speed_slider").value = options.player_approaching_speed
    find_node("enemy_approaching_speed_label").text = "%1.1f" % [options.enemy_approaching_speed]
    find_node("enemy_approaching_speed_slider").value = options.enemy_approaching_speed
    find_node("attack_speed_label").text = "%1.1f" % [options.attack_speed]
    find_node("attack_speed_slider").value = options.attack_speed

func _on_game_speed_slider_value_changed(value):
    options.game_speed = value
    update_view()

func _on_player_approaching_speed_slider_value_changed(value):
    options.player_approaching_speed = value
    update_view()

func _on_enemy_approaching_speed_slider_value_changed(value):
    options.enemy_approaching_speed = value
    update_view()

func _on_attack_speed_slider_value_changed(value):
    options.attack_speed = value
    update_view()

func _on_continue_button_pressed():
    options.save_to_file()
    scene_stack.pop()

# ---------------------------------------------------------------------------------------------

func ss_init():
    pass
func ss_resume():
    pass
func ss_suspend():
    pass
func ss_end():
    utils.remove_node(self)
