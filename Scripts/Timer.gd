extends Node2D

onready var Lobby = get_tree().get_root().get_node('Lobby')

var countdown = false
var current_time = 0
var target_time = 1
var running = false
signal reach_target_time

var s_receiver
var s_message

var removed = false

func _ready():
    # Called every time the node is added to the scene.
    # Initialization here
    $gauge.max_value = target_time

func _process(delta):
    if not running: return
    current_time += delta * Lobby.speed_up
    $gauge.value = current_time
    $time.text = "%1d" % (target_time - current_time + 1)
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

    s_receiver = signal_receiver
    s_message = signal_message
    connect("reach_target_time", self, 'reached_time')

func reached_time(timer):
    remove_me()
    funcref(s_receiver, s_message).call_func()

func remove_me():
    if removed: return
    removed = true
    
    pause()
    get_parent().remove_child(self)
    queue_free()

    if s_receiver:
        s_receiver.organize_timer_positions()

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
