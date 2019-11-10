extends NinePatchRect

onready var Game = get_tree().get_root().get_node('Game')

export var lane = 'left' # middle, right
export var side = 'enemy' # friendly
export(Vector2) var familiar_position = Vector2(0, 0)

var card
var tower

func _ready():
    hide()

func is_left(): return lane == 'left'
func is_middle(): return lane == 'middle'
func is_right(): return lane == 'right'

func is_unoccupied():
    return not is_occupied()
func is_occupied():
    return card != null

func is_hovered():
    return modern_is_hovered()
#    update_area()
#    var hovered = false
#    var space = get_world_2d().get_direct_space_state()
#    var results = space.intersect_point(get_global_mouse_position())
#    for result in results:
#        if result.collider == find_node('area'):
#            hovered = true
#    return hovered

func modern_is_hovered():
    var mouse = get_global_mouse_position()
    return mouse.x > margin_left and mouse.y > margin_top and mouse.x < margin_right and mouse.y < margin_bottom
    
func update_area():
    var coll = $area/collision
    coll.position = rect_size / 2
    var shape = coll.shape
    shape.set_extents(rect_size / 2)

func _process(delta):
    update_area()
    if is_hovered():
        show()
    else:
        hide()

func get_familiar_position():
    return rect_position + familiar_position

func opposing_field():
    for field in Game.fields():
        if field.side != side && field.lane == lane:
            return field

func field_to_the_right_in_ring():
    var query_lane
    if lane == 'left': query_lane = 'middle'
    if lane == 'middle': query_lane = 'right'
    if lane == 'right': query_lane = 'left'
    
    for field in Game.fields():
        if field.side == side && field.lane == query_lane:
            return field
