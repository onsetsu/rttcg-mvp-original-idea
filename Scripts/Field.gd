extends NinePatchRect

onready var Game = get_tree().get_root().get_node('Game')

export var lane = 'left' # middle, right
export var side = 'enemy' # friendly
export var type = 'tower' # familiar

var card
var tower

func _ready():
    # Called every time the node is added to the scene.
    # Initialization here
    hide()

func is_empty():
    return type == 'familiar' && card == null

func is_hovered():
    update_area()
    var hovered = false
    var space = get_world_2d().get_direct_space_state()
    var results = space.intersect_point(get_global_mouse_position())
    for result in results:
        if result.collider == find_node('area'):
            hovered = true
    return hovered

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

func center_position(): return rect_position + rect_size / 2

func opposing_familiar_field():
    for field in Game.fields():
        if field.type == 'familiar' && field.side != side && field.lane == lane:
            return field

func opposing_tower_field():
    for field in Game.fields():
        if field.type == 'tower' && field.side != side && field.lane == lane:
            return field

func friendly_familiar_field():
    for field in Game.fields():
        if field.type == 'familiar' && field.side == side && field.lane == lane:
            return field

func friendly_tower_field():
    for field in Game.fields():
        if field.type == 'tower' && field.side == side && field.lane == lane:
            return field

func all_fields_in_same_lane():
    return utils.filter_prop(Game.fields(), 'lane', lane)

func field_to_the_right_in_ring():
    var query_lane
    if lane == 'left': query_lane = 'middle'
    if lane == 'middle': query_lane = 'right'
    if lane == 'right': query_lane = 'left'
    
    for field in Game.fields():
        if field.type == type && field.side == side && field.lane == query_lane:
            return field

func receive_damage(x):
    pass
