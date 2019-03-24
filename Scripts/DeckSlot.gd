extends PanelContainer

var card_scene = preload("res://Scenes/Card.tscn")
var card
var card_name
var num_copies = 0

func _ready():
    set_process_input(true)
    
    var card_container = $VBoxContainer/card_container
    card = card_scene.instance()
    
    card_container.add_child(card)
    card.position = card_container.rect_size / 2

func set_card(name, copies = 0):
    self.card_name = name
    card.become(name)
    num_copies = copies
    
func _process(delta):
    find_node('num_label').text = str(num_copies)

func _input(event):
    # make sure we click inside the visible area of  our scroll parent
    var parent = self
    while parent.get_class().get_basename() != 'ScrollContainer':
        parent = parent.get_parent()
    var visible_in_container = parent.get_global_rect().has_point(get_global_mouse_position())

    if is_visible_in_tree() && event.is_pressed() && event.button_index > 0 && event.button_index <= 2 && visible_in_container && get_global_rect().has_point(get_global_mouse_position()):
        var diff = 1
        if event.button_index == 2:
            diff = -1
        num_copies += diff
        num_copies = max(num_copies, 0)
