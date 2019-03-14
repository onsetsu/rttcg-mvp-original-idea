extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var field
var hp = 15

func _ready():
    # Called every time the node is added to the scene.
    # Initialization here
    pass

func add_to_field(field):
    self.field = field
    field.tower = self

func _process(delta):
    $hp.text = str(max(hp,0))

func receive_damage(amount):
    hp -= amount

func heal(amount):
    hp += amount
