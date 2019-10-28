extends Node2D

onready var Lobby = get_tree().get_root().get_node('Lobby')

var countdown = false
var current_time = 0.0
var target_time = 1.0
var running = false
signal reach_target_time

var s_receiver
var s_message

var removed = false

var slow_multiplier = 0.6
var haste_multiplier = 1.6

func _ready():
    # Called every time the node is added to the scene.
    # Initialization here
    $gauge.max_value = target_time

func _process(delta):
    if not running: return
    
    var multiplier = 1.0
    if s_receiver and s_receiver.haste and $name.text != 'combo':
        multiplier *= haste_multiplier
    if s_receiver and s_receiver.slow and $name.text != 'combo':
        multiplier *= slow_multiplier
    current_time += delta * options.game_speed * multiplier * Lobby.speed_pause_modifier
    
    $gauge.value = current_time
    $time.text = "%1d" % (target_time - current_time + 1)
    if(current_time > target_time):
        current_time = target_time
        stop()
        emit_signal("reach_target_time", self)

# TODO: down ignored for now
func init(action_name, target_time_, signal_receiver, signal_message):
    set_action_name(action_name)
    current_time = 0.0
    $gauge.min_value = 0.0
    set_target_time(target_time_)

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
        if s_receiver.charge_timer == self:
            s_receiver.charge_timer = null

func start():
    running = true

func pause():
    running = false

func resume():
    running = true

func stop():
    running = false
    
func reset():
    current_time = 0.0

func increase_duration_by(duration):
    set_target_time(target_time + duration)

func set_target_time(value):
    target_time = value
    $gauge.max_value = target_time

func set_action_name(action_name):
    $name.text = action_name
