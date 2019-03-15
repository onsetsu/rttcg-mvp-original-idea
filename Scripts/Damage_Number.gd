extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
    # Called every time the node is added to the scene.
    # Initialization here
    # config(-2, 'at', Vector2(200, 200))
    pass

#func _process(delta):
#    # Called every frame. Delta is time since last frame.
#    # Update game logic here.
#    pass

func start(target, text, color = Color(1,1,1,0.5)):
    $text.text = str(text)
    $text.set("custom_colors/font_color", color)
    global_position = target.global_position
    
    return self

func config(amount, type, pos):
    if amount > 0:
        $Label.set("custom_colors/font_color",Color(0,1,0)) # green
    else: if amount < 0:
        $Label.set("custom_colors/font_color",Color(1,0,0))
    else:
        $Label.set("custom_colors/font_color",Color(0.8,0.8,0.8))

    #text = str(amount) + ' ' + type
    start_anim(pos)
    
func start_anim(pos):
    position = pos

func _on_AnimationPlayer_animation_finished(anim_name):
    queue_free()
