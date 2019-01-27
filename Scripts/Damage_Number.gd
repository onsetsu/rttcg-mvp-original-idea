extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
    # Called every time the node is added to the scene.
    # Initialization here
    config(-2, 'at', Vector2(200, 200))

#func _process(delta):
#    # Called every frame. Delta is time since last frame.
#    # Update game logic here.
#    pass

func config(amount, type, pos):
    if amount > 0:
        $Label.set("custom_colors/font_color",Color(0,1,0)) # green
    else: if amount < 0:
        $Label.set("custom_colors/font_color",Color(1,0,0))
    else:
        $Label.set("custom_colors/font_color",Color(0.8,0.8,0.8))

    text = str(amount) + ' ' + type
    start_anim(pos)
    
func start_anim(pos):
    position = pos