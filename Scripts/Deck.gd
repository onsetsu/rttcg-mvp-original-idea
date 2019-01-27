extends Node2D

onready var Game = get_tree().get_root().get_node('Game')

var index = 0
export var side = 'friendly' # enemy
export var card_list = 'DECK' # ENEMY_DECK, EXTRA_DECK

# Separator
# ---------------------------------------------------------------------------------------------

func create_next_card():
    var card = Game.create_card(position)
    card.add_to_group(side)

    var list = Game[card_list]
    var card_name = list[index%list.size()]
    Game.apply_onto(card, card_name)
    
    index += 1

    return card
