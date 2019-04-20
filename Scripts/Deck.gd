extends Node2D

onready var Game = get_tree().get_root().get_node('Game')

export var side = 'friendly' # enemy

var current_cards = []
var deck_list

func reshuffle_deck():
    current_cards = utils.shuffle(deck_list)

func create_next_card():
    var card = Game.create_card(position)
    card.add_to_group(side)

    if current_cards.empty():
        reshuffle_deck()

    var card_name = current_cards.pop_front()
    card.become(card_name)

    return card

func set_deck_list(list):
    deck_list = [] + list
