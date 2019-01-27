extends Node2D

# class member variables go here, for example:
# var a = 2
var countdown = false
var current_time = 0
var target_time = 0
var running = false
signal reach_target_time

func _ready():
    # Called every time the node is added to the scene.
    # Initialization here
    pass

func _process(delta):
    if not running: return
    current_time += delta
    $gauge.value = current_time
    $time.text = "%.1f s" % (target_time - current_time)
    if(current_time > target_time):
        current_time = target_time
        stop()
        emit_signal("reach_target_time", self)

# TODO: down ignored for now
func init(action_name, target_time_, signal_receiver, signal_message):
    $name.text = action_name
    current_time = 0
    target_time = target_time_
    $gauge.min_value = 0
    $gauge.max_value = target_time
    connect("reach_target_time", signal_receiver, signal_message)

func start():
    running = true

func pause():
    running = false

func resume():
    running = true

func stop():
    running = false
    
func reset():
    current_time = 0
