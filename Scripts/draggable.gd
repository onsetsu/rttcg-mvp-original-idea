extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var mouseIn = false

func _ready():
    # Called every time the node is added to the scene.
    # Initialization here
    pass

func _process(delta):
    if(mouseIn && Input.is_action_pressed('click')):
        set_position(get_viewport().get_mouse_position())


func _on_Area2D_mouse_entered():
    print('Mouse entered')
    mouseIn = true


func _on_Area2D_mouse_exited():
    print('Mouse exited')
    mouseIn = false
