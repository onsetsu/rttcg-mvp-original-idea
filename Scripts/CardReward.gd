extends Control

onready var Lobby = get_tree().get_root().get_node('Lobby')
var card_scene = preload("res://Scenes/Card.tscn")

onready var left = $Node/PanelContainer/Panel/card_left
onready var middle = $Node/PanelContainer/Panel/card_middle
onready var right = $Node/PanelContainer/Panel/card_right

# Called when the node enters the scene tree for the first time.
func _ready():
    init_card_selection() # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass

func all_cards(condition):
    var result = []
    var card_names = Lobby.card_names()
    for card_name in card_names:
        var card = card_scene.instance()
        card.become(card_name)
        result.append(card)
    var filtered = utils.filter_props(result, condition)
    return utils.pluck(filtered, 'key')

# #TODO: sample_n for sampling 3 card without wiederholungen
func init_card_selection():
    var player_cards = all_cards({generated = false, deck = 'player'})
    init_card(left, utils.sample(player_cards))
    init_card(middle, utils.sample(player_cards))
    init_card(right, utils.sample(player_cards))
    
func init_card(card, key):
    card.become(key)

func _on_pick_left():
    pick_card(left.key)
    return_to_lobby()

func _on_pick_middle():
    pick_card(middle.key)
    return_to_lobby()

func _on_pick_right():
    pick_card(right.key)
    return_to_lobby()

func pick_card(key):
    Lobby.inc_amount_in_grid(key)
    Lobby.sort_grids()

func return_to_lobby():
    Lobby.return_from_card_reward()
