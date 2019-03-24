extends Node2D

onready var Game = get_tree().get_root().get_node('Game')

var index = 0
export var side = 'friendly' # enemy

var deck_list

# Separator
# ---------------------------------------------------------------------------------------------

func create_next_card():
    var card = Game.create_card(position)
    card.add_to_group(side)

    var card_name = deck_list[index%deck_list.size()]
    card.become(card_name)

    index += 1

    return card

func set_deck_list(list):
    deck_list = [] + list
