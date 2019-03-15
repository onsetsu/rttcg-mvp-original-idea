extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

var field
var hp = 15

onready var Game = get_tree().get_root().get_node('Game')
var hint_scene = preload("res://Scenes/Damage_Number.tscn")

func _ready():
    # Called every time the node is added to the scene.
    # Initialization here
    pass

func add_to_field(field):
    self.field = field
    field.tower = self

func _process(delta):
    hp = max(hp, 0)
    $hp.text = str(hp)

func receive_damage(amount):
    Game.add_child(hint_scene.instance().start(self, amount, Color(1,0,0)))
    hp -= amount

func heal(amount):
    Game.add_child(hint_scene.instance().start(self, "+%1d" % amount, Color(0,1,0)))
    hp += amount
