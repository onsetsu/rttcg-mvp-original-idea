extends Node2D

var mouseIn = false
var isDragging = false

var deck = 'player'

var key = 'Flamekin'
var card_name = 'Flamekin'
var text = 'No text here.'
var element = 'fire' setget set_element, get_element # water, earth 

var type = 'familiar' # sorcery

# for sorceries
var targeting
var effect

# for familiars
var at = 1
var hp = 1

var battlecry
var deathrottle
var sabotage
var combo
var inspire
var whenever = {}
var ignition

var haste = false
var slow = false

var charged = false
var charge_time = -1
var charge_timer

var effect_store = {}

var field

var attack_charge_timer
var attack_timer_running = false
var attacking = false
var attacks_a_tower = false

var enemy_ai = 'enemy_ai__random_possible_target'

var start_offset
onready var Game = get_tree().get_root().get_node('Game')
var timer_scene = preload("res://Scenes/Timer.tscn")

func _ready():
    update_appearance()

func go_to(target_position, duration = 1.0, transition_type = Tween.TRANS_BACK, ease_type = Tween.EASE_OUT):
    $pos_tween.interpolate_property(self,
        'position',
        position,
        target_position,
        duration,
        transition_type,
        ease_type
    )
    $pos_tween.start()

func cancel_go_to():
    $pos_tween.stop_all()

func is_hovered():
    var hovered = false
    var space = get_world_2d().get_direct_space_state()
    var results = space.intersect_point( get_global_mouse_position())
    for result in results:
        if result.collider == find_node('area'):
            hovered = true
    return hovered

func set_element(e):
    element = e
    $frame/element.set_element(e)

func get_element():
    return element

func get_frame_offset():
    var width = 192
    if element == 'fire': return 0
    if element == 'water': return width
    if element == 'earth': return 2 * width
    return 0

func update_appearance():
    $frame/name.text = card_name
    $frame/element.set_element(element)
    $frame.region_rect.position.x = get_frame_offset()
    $frame/text.text = str(text)

    if is_familiar():
        $frame/at.text = str(at)
        $frame/hp.text = str(hp)
    else:
        $frame/at.hide()
        $frame/hp.hide()

func drag_start():
    add_to_group('drag')

    start_offset = get_local_mouse_position() * scale
    cancel_go_to()
    
    if charge_time > 0:
        charge_timer = start_timer(charge_time, 'charge_complete', 'charge')

func charge_complete():
    display_hint('charged', Color(1,1,1))
    charged = true

func drag():
    set_position(get_viewport().get_mouse_position() - start_offset)

func drag_end():
    remove_from_group('drag')

    Game.try_to_play_card(self)
    
    charged = false
    if charge_timer != null:
        charge_timer.remove_me()
    
    Game.organize_hand() # need to reorganize hand regardless whether actually played or not

func _process(delta):
    if at < 0:
        at = 0

    update_appearance()
    
    # --- ignition ---
    if Input.is_action_just_pressed('click') && on_field() && is_hovered():
        exec_ignition()
    
    # --- drag from hand ---
    if Input.is_action_just_pressed('click') && is_in_group('hand') && get_tree().get_nodes_in_group("drag").size() == 0 && is_hovered():
        drag_start()
    if Input.is_action_pressed('click') && is_in_group('drag'):
        drag()
    if Input.is_action_just_released('click') && is_in_group('drag'):
        drag_end()

    # --- attacking ---    
    if is_in_group('field') && !(attack_timer_running || attacking):
        setup_charge_to_attack()

func organize_timer_positions():
    var i = 0
    for timer in $timers.get_children():
        timer.position = i * Vector2(-40, 0)
        i += 1

func _create_timer():
    var timer = timer_scene.instance()
    $timers.add_child(timer)
    organize_timer_positions()
    return timer

func start_timer(duration, method_to_invoke, label):
    var timer = _create_timer()
    timer.init(label, duration, self, method_to_invoke)
    timer.start()
    return timer

func add_approaching_timer(method_to_invoke, label):
    start_timer(5, method_to_invoke, label)

# callback
func draw_approaching_card():
    clear_timers()
    remove_from_group("approaching")
    add_to_hand()

#callback
func play_enemy_card():
    remove_from_group("approaching")
    var successfully_played = Game.try_to_play_enemy_card(self)
    if not successfully_played:
        queue_free()

# animation and juice
# ---------------------------------------------------------------------------------------------
func display_hint(message, color):
    Game.display_hint(self, message, color)

# accessing/querying
# ---------------------------------------------------------------------------------------------

func is_familiar():
    return type == 'familiar'

func is_sorcery():
    return type == 'sorcery'

func side():
    if is_allied():
        return 'friendly'
    else: if is_enemy():
        return 'enemy'

func is_allied():
    return is_in_group('friendly')

func is_enemy():
    return is_in_group('enemy')

func is_fire():
    return element == 'fire'

# targeting
# ---------------------------------------------------------------------------------------------

func check_targeting(target_field):
    if is_familiar():
        return targets_own_unoccupied_familiar_field(target_field)
    return funcref(self, targeting).call_func(target_field)

func targets_own_unoccupied_familiar_field(target_field):
    if is_allied():
        return targets_friendly_unoccupied_familiar_field(target_field)
    else:
        return targets_friendly_unoccupied_enemy_field(target_field)
    
func targets_friendly_unoccupied_familiar_field(target_field):
    return target_field in Game.unoccupied_friendly_familiar_fields()

func targets_friendly_unoccupied_enemy_field(target_field):
    return target_field in Game.unoccupied_enemy_familiar_fields()

func targets_friendly_familiar(target_field):
    return target_field in Game.occupied_friendly_familiar_fields()

func targets_familiar(target_field):
    if (target_field == null):
        print('no field selected')
        return false # did not play the card
    if (target_field.type != 'familiar'):
        print('no field for familiar')
        return false # cannot play on tomers for now
    var card_on_field = target_field.card
    if (card_on_field == null):
        print('field not occupied')
        return false # field occupied
    return true

func targets_tower(target_field):
    if (target_field == null):
        print('no field selected')
        return false # did not play the card
    if (target_field.type != 'tower'):
        print('no field for tower')
        return false # cannot play on tomers for now
    var tower_on_field = target_field.tower
    if (tower_on_field == null):
        print('field not occupied')
        return false # field occupied
    if (tower_on_field.hp <= 0):
        print('tower dead')
        return false # tower dead
    return true

func targets_familiar_or_tower(target_field):
    return targets_familiar(target_field) or targets_tower(target_field)

func targets_field(target_field):
    return target_field != null

func targets_not_required(target_field):
    return true

func targets_unoccupied_friendly_field():
    pass

func targets_familiar_combo_not_required(target_field):
    if Game.has_combo_card():
        return targets_not_required(target_field)
    else:
        return targets_familiar(target_field)

func targets_familiar_with_empty_field_to_the_right(target_field):
    return targets_familiar(target_field) and target_field.field_to_the_right_in_ring().is_empty()

# play from hand
# ---------------------------------------------------------------------------------------------

func play(target_field, allied):
    if is_familiar():
        add_to_field(target_field) # add to battlefield
        exec_battlecry()
        if allied && Game.has_combo_card():
            exec_combo(target_field)
        #Game.event('play_familiar', self)
    else:
        if allied && Game.has_combo_card() && combo != null:
            exec_combo(target_field)
        else:
            funcref(self, effect).call_func(target_field)
        #Game.event('cast_sorcery', self)
        queue_free()

    if allied:
        if Game.has_combo_card():
            Game.get_combo_card().exec_inspire(self)
    
        make_copy_the_combo_card()
    
    Game.event('play_card', self)

func play_ally(target_field):
    return play(target_field, true)

func play_enemy(target_field):
    return play(target_field, false)

# enemy ai
# ---------------------------------------------------------------------------------------------

func exec_enemy_ai():
    return funcref(self, enemy_ai).call_func()

func possible_targets():
    var targets = []
    for field in Game.fields():
        if check_targeting(field):
            targets.append(field)
    return targets

func enemy_ai__any_possible_target():
    var targets = possible_targets()
    if targets.empty():
        return false
    return targets[0]

func enemy_ai__random_possible_target():
    var targets = possible_targets()
    if targets.empty():
        return false
    return utils.shuffle(targets)[0]

# whenever effects
# ---------------------------------------------------------------------------------------------

func exec_whenever(name, arg):
    if whenever.has(name):
        funcref(self, whenever[name]).call_func(arg)

func on_field__plus_1_plus_1(arg):
    if is_in_group('field'):
        buff(1, 1)

func this__plus_3_plus_0(arg):
    if self == arg:
        buff(3, 0)

func own_familiar__plus_2_plus_2(card):
    if is_approaching() && card.is_familiar() && side() == card.side():
        card.buff(2, 2)

func approaching__cast_on_familiar(card):
    if is_approaching() && card.is_familiar() && side() != card.side():
        deal_x_familiar(card, 4) # TODO: actual cast
        queue_free()

func approaching__deal_2_to_familiar(card):
    if is_approaching() && card.is_familiar() && side() != card.side():
        deal_x_familiar(card, 2)

func in_hand__delay_10_transform__to_treant(card):
    if self == card:
        start_timer(10, 'timed_transform_to_treant', 'grow')
func timed_transform_to_treant():
    become('Treant')

func in_hand__delay_5_discard(card):
    if self == card:
        start_timer(5, 'timed_discard_self', 'discard')
func timed_discard_self():
    discard()

# sorcery effects
# ---------------------------------------------------------------------------------------------

func deal_2(target_field):
    deal_x(target_field, 2)

func deal_3(target_field):
    deal_x(target_field, 3)

func deal_4(target_field):
    deal_x(target_field, 4)

func deal_5(target_field):
    deal_x(target_field, 5)

func sorcery__deal_5(target_field):
    deal_x(target_field, 5)

func deal_6(target_field):
    deal_x(target_field, 6)

func sorcery__deal_3_charged_6(target_field):
    if charged:
        deal_x(target_field, 6)
    else:
        deal_x(target_field, 3)
    
func deal_5_all_enemy_familiars(target_field):
    for familiar in Game.enemy_familiars():
        deal_x_familiar(familiar, 5)

func plus_2_plus_2(target_field):
    target_field.card.buff(2, 2)

func plus_3_plus_3(target_field):
    target_field.card.buff(3, 3)

func plus_1_plus_1_then_attack(target_field):
    var familiar = target_field.card
    familiar.buff(1, 1)
    familiar.attack_immediately()

func plus_3_plus_3_then_attack(target_field):
    var familiar = target_field.card
    familiar.buff(3, 3)
    familiar.attack_immediately()

func create_2_shivs(target_field):
    create_x_shivs(2)

func copy_twice(target_field):
    var key = target_field.card.key
    create(key).add_to_hand()
    create(key).add_to_hand()

func transform_allies_into_dragons(target_field):
    for familiar in Game.friendly_familiars():
        familiar.become_a_dragon()

func draw_one_for_each_enemy_familiar(target_field):
    for familiar in Game.enemy_familiars():
        Game.draw_a_card()

func opponent_discards_all_sorceries(target_field):
    for card in utils.get_nodes_in_groups(['hand', 'friendly']):
        if card.is_sorcery():
            card.discard()
    Game.organize_hand()

func deal_3_if_approching_fire_deal_6(target_field):
    var approaching_card = Game.get_approaching_card()
    if  approaching_card && approaching_card.is_fire():
        deal_x(target_field, 6)
    else:
        deal_x(target_field, 3)

func deal_4_all_in_lane(target_field):
    deal_x_all_in_lane(target_field, 4)

func sorcery__return_to_hand(target_field):
    target_field.card.return_to_hand()

func sorcery__shift_to_right(target_field):
    target_field.card.move_to_field(target_field.field_to_the_right_in_ring())

func sorcery__minus_4_minus_2(target_field):
    target_field.card.debuff(4, 2)

func sorcery__all_minus_4_minus_4_delay_plus_4_plus_4(target_field):
    for familiar in Game.familiars_on_field():
        familiar.start_timer(5, 'timed_plus_4_plus_4', '+4/+4')
        familiar.debuff(4, 4)
func timed_plus_4_plus_4():
    buff(4, 4)

func sorcery__plus_5_plus_5_delay_selfdestruct(target_field):
    target_field.card.start_timer(5, 'timed_selfdestruct', 'self-destruct')
    target_field.card.buff(5, 5)
func timed_selfdestruct():
    die()

func sorcery__draw_3_delay_discard(target_field):
    for i in [1,2,3]:
        var card = Game.draw_a_card()
        card.start_timer(5, 'timed_discard', 'discard')
func timed_discard():
    discard()

func sorcery__deal_3_delay_deal_3(target_field):
    var familiar = target_field.card
    familiar.start_timer(3, 'timed_receive_3_damage', '3 damage')
    familiar.receive_damage(3)
func timed_receive_3_damage():
    receive_damage(3)

func sorcery__deal_1_every_2_seconds(target_field):
    target_field.card.add_poison()
func add_poison():
    start_timer(2, 'timed_poison', 'poison')
func timed_poison():
    add_poison()
    receive_damage(1)

func sorcery__plus_2_plus_2_charged_return_to_hand(target_field):
    target_field.card.buff(2, 2)
    if charged:
        create(key).add_to_hand()

# battlecries
# ---------------------------------------------------------------------------------------------

func exec_battlecry():
    if battlecry != null:
        funcref(self, battlecry).call_func()

func battlecry__attack_immediately():
    attack_immediately()

func create_a_shiv():
    create_x_shivs(1)

func battlecry__deal_2_in_lane():
    deal_x_in_lane(2)

func battlecry__deal_4_in_lane():
    deal_x_in_lane(4)

func battlecry__deal_8_in_lane():
    deal_x_in_lane(8)

func battlecry__fill_board_with_sheeps():
    fill_your_board_with('Sheep')

func battlecry__swap_hp_opposing_familiar():
    if not field.opposing_familiar_field().is_empty():
        var opposing_familiar = field.opposing_familiar_field().card
        var opposing_hp = opposing_familiar.hp
        opposing_familiar.hp = hp
        hp = opposing_hp
    else:
        print('no familiar found')
    
func battlecry__return_others_to_hand():
    for f in Game.friendly_familiars():
        if f != self:
            f.return_to_hand()

func battlecry__deal_2_familiars_in_other_lanes():
    if not field:
        return
    var this_lane = field.lane

    var familiars = Game.familiars_on_field()
    for familiar in familiars:
        if familiar.field and familiar.field.lane != this_lane:
            deal_x_familiar(familiar, 2)

func battlecry__delay_8_become_a_dragon():
    start_timer(8, 'timed_become_a_dragon', 'become dragon')
func timed_become_a_dragon():
    become_a_dragon()

func battlecry__every_2_allies_other_lanes_plus_0_plus_2():
    start_timer(2, 'timed_allies_other_lanes_plus_0_plus_2', 'heal 2')
func timed_allies_other_lanes_plus_0_plus_2():
    if not field:
        return

    var allies = Game.friendly_familiars()
    for ally in allies:
        if ally.field and ally.field.lane != field.lane:
            ally.buff(0, 2)

    battlecry__every_2_allies_other_lanes_plus_0_plus_2()

func battlecry__every_4_draw_1_discard_leftmost():
    start_timer(4, 'timed_draw_1_discard_leftmost', 'draw, discard')
func timed_draw_1_discard_leftmost():
    if not field:
        return

    Game.draw_a_card()
    Game.discard_leftmost_card()

    battlecry__every_4_draw_1_discard_leftmost()

func battlecry__opponent_discard_leftmost():
    Game.discard_leftmost_card()

func battlecry__every_4_create_a_shiv():
    start_timer(4, 'timed_create_a_shiv', 'shiv')
func timed_create_a_shiv():
    if not field:
        return

    create_x_shivs(1)
    battlecry__every_4_create_a_shiv()

func battlecry__every_2_deal_1_opposing_side():
    start_timer(2, 'timed_deal_1_opposing_side', 'deal 1')
func timed_deal_1_opposing_side():
    if not field:
        return

    deal_x_in_lane(1)
    battlecry__every_2_deal_1_opposing_side()

func battlecry__heal_5_guarded_tower():
    if not field:
        return

    field.friendly_tower_field().tower.heal(5)

func battlecry__charged_swap_at_hp():
    if charged:
        swap_at_hp()

func battlecry__attacks_immediately_charged_instead_plus_3_plus_3():
    if charged:
        buff(3, 3)
    else:
        attack_immediately()

func battlecry__charged_fill_your_board_with_copies_of_this():
    if charged:
        fill_your_board_with(key)

func battlecry__draw_approaching_card():
    Game.ensure_approaching_card_player().draw_approaching_card()

# deathrottle
# ---------------------------------------------------------------------------------------------

func exec_deathrottle(from_field):
    if deathrottle != null:
        display_hint('deathrottle', Color(1,0,1))
        funcref(self, deathrottle).call_func(from_field)

func deathrottle__split_into_2_4s(from_field):
    create('Ooze').add_to_field(from_field)
    create('Ooze').add_to_hand()

func deathrottle__deal_2_in_lane(from_field):
    deal_x_in_lane(2, from_field)

func deathrottle__great_phoenix(from_field):
    create('GreatPhoenix').add_to_hand()

func deathrottle__blazing_phoenix(from_field):
    create('BlazingPhoenix').add_to_hand()

func deathrottle__fill_board_with_hobgoblins(from_field):
    fill_your_board_with('Hobgoblin')

# sabotage
# ---------------------------------------------------------------------------------------------

func exec_sabotage():
    if sabotage != null:
        funcref(self, sabotage).call_func()

func sabotage__draw_a_card():
    if not effect_store.has('looted_for_a_card'):
        effect_store['looted_for_a_card'] = true
        Game.draw_a_card()

func sabotage__become_a_dragon():
    become_a_dragon()

# combo
# ---------------------------------------------------------------------------------------------

func exec_combo(target_field):
    if combo != null:
        funcref(self, combo).call_func(target_field)

func combo__create_a_shiv(target_field):
    create_x_shivs(1)

func combo__deal_2_then_return_to_hand(target_field):
    deal_x(target_field, 2)
    create('Bumerang').add_to_hand()

func combo__plus_2_plus_2_to_all(target_field):
    for familiar in Game.friendly_familiars():
        familiar.buff(2, 2)

func combo__plus_2_plus_2(target_field):
    buff(2, 2)

func combo__attacks_immediately(target_field):
    attack_immediately()

func deal_3_then_deal_3_to_tower(target_field):
    deal_x(target_field, 3)
    deal_x(target_field.friendly_tower_field(), 3)

func combo__copy_to_hand(target_field):
    create(key).add_to_hand()

func combo__plus_1_plus_0_to_all(target_field):
    for familiar in Game.friendly_familiars():
        familiar.buff(1, 0)

# inspire
# ---------------------------------------------------------------------------------------------

func exec_inspire(inspired_card):
    if inspire != null:
        funcref(self, inspire).call_func(inspired_card)

func inspire__plus_2_plus_2(inspired_card):
    if inspired_card.is_familiar():
        inspired_card.buff(2, 2)

func inspire__attack_immediately(inspired_card):
    if inspired_card.is_familiar():
        inspired_card.attack_immediately()

func inspire__copy_to_hand(inspired_card):
    create(inspired_card.key).add_to_hand()

func inspire__create_a_shiv(inspired_card):
    create_x_shivs(1)

func inspire__become_a_dragon(inspired_card):
    inspired_card.become_a_dragon()

# ignition
# ---------------------------------------------------------------------------------------------

func exec_ignition():
    if ignition != null:
        funcref(self, ignition).call_func()

func ignition__plus_1_minus_1():
    buff(1, -1)
    check_for_death()

func ignition__deal_2_all_in_lane():
    deal_x_all_in_lane(field, 2)

# effect utils
# ---------------------------------------------------------------------------------------------

func deal_x(target_field, amount):
    if target_field.type == 'familiar' && target_field.card != null:
        target_field.card.receive_damage(amount)
    else:
        target_field.tower.receive_damage(amount)

func deal_x_familiar(familiar, amount):
    familiar.receive_damage(amount)

func deal_x_in_lane(x, f = field):
    var familiar_field = f.opposing_familiar_field()
    if familiar_field.is_empty():
        deal_x(f.opposing_tower_field(), x)
    else:
        deal_x(familiar_field, x)

func deal_x_all_in_lane(target_field, amount):
    for f in target_field.all_fields_in_same_lane():
        if f.type == 'familiar' && f.card == null: # no familiar on field
            pass
        else:
            deal_x(f, amount)

func buff(at_improvement, hp_improvement):
    display_hint('+%1d/+%1d' % [at_improvement, hp_improvement], Color(0,1,0))
    at += at_improvement
    hp += hp_improvement

func debuff(at_improvement, hp_improvement):
    display_hint('-%1d/-%1d' % [at_improvement, hp_improvement], Color(0.7,0,0.7))
    at -= at_improvement
    hp -= hp_improvement
    check_for_death()

func swap_at_hp():
    var temp_at = at
    at = hp
    hp = temp_at
    check_for_death()
    
func create_x_shivs(x):
    for i in range(x):
        create('Shiv').add_to_hand()

func create(name):
    return Game.create_card_by_name(position, name, side())

func attack_immediately():
    cancel_attacking()
    attacking()

func become_a_dragon():
    become('Dragon')

func become(name):
    funcref(cards, name).call_func(self)

func discard():
    if is_in_group('hand') and is_in_group('friendly'):
        display_hint('discard', Color(1,0,1))
        remove_from_hand()
        queue_free()
        Game.organize_hand()
    else:
        print('could not discard')

func return_to_hand():
    remove_from_field()
    add_to_hand()

func fill_your_board_with(card_key):
    var fields
    if is_enemy():
        fields = Game.unoccupied_enemy_familiar_fields()
    else:
        fields = Game.unoccupied_friendly_familiar_fields()
    for unoccupied_field in fields:
        create(card_key).add_to_field(unoccupied_field)

# zone changes
# ---------------------------------------------------------------------------------------------

func is_approaching():
    return is_in_group('approaching')

func move_to_field(new_field):
    if field:
        field.card = null
        field = null
    field = new_field
    field.card = self
    go_to(field.center_position(), 0.3)

func add_to_field(field):
    add_to_group('field')
    self.field = field
    field.card = self
    go_to(field.center_position(), 0.3)

func remove_from_field():
    # needs to be called explicitly, because we have an extra instance 
    # variable 'attack_charge_timer' that would otherwise still refer to this timer 
    # #TODO: refactor properly
    cancel_attacking()
    clear_timers()
    if is_in_group('field'):
        remove_from_group('field')
    if field:
        var temp_field = field
        field.card = null
        field = null
        # TODO: we only sometimes return a field, deathrottles might fail if we do not return properly
        return temp_field

func on_field():
    return is_in_group('field') && field != null && field.card == self

func add_to_hand():
    add_to_group("hand")
    Game.organize_hand()
    Game.event("add_to_hand", self)

func remove_from_hand():
    clear_timers()
    remove_from_group('hand')

func clear_timers():
    for timer in $timers.get_children():
        timer.remove_me()

# comboing
# ---------------------------------------------------------------------------------------------

func make_copy_the_combo_card():
    Game.make_combo_card(key)

#callback
func remove_combo_card():
    queue_free()

# attacking
# ---------------------------------------------------------------------------------------------

func clear_attack_charge_timer():
    if attack_charge_timer != null:
        attack_charge_timer.remove_me()
        attack_charge_timer = null
    
    attack_timer_running = false
    
func cancel_attacking():
    clear_attack_charge_timer()
    attacking = false
    attacks_a_tower = false
    
    if $pos_tween.is_connected('tween_completed', self, 'attack_contact'):
        $pos_tween.disconnect('tween_completed', self, 'attack_contact')
    if $pos_tween.is_connected('tween_completed', self, 'attack_released'):
        $pos_tween.disconnect('tween_completed', self, 'attack_released')

    cancel_go_to()
    # TODO: for some reason, this go_to makes the card snap to its fields center position after connection with the attack target
    #go_to(field.center_position(), 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)

func setup_charge_to_attack():
    attack_timer_running = true
    attack_charge_timer = start_timer(3, 'attacking', 'attack')

#callback
func attacking():
    clear_attack_charge_timer()
    start_attacking()
    
func start_attacking():
    if not on_field():
        return
    
    attacking = true
    
    attacks_a_tower = !field.opposing_familiar_field().card
    var target_pos
    if attacks_a_tower:
        target_pos = field.opposing_tower_field().center_position()
    else:
        target_pos = field.opposing_familiar_field().center_position()
    
    # attack animation
    $pos_tween.connect('tween_completed', self, 'attack_contact')
    go_to(target_pos, 0.5, Tween.TRANS_QUINT, Tween.EASE_IN)

func attack_contact(unused, unused2):
    $pos_tween.disconnect('tween_completed', self, 'attack_contact')
    
    Game.event('attack', self)
    
    if(attacks_a_tower):
        attack_that_tower(field.opposing_tower_field().tower)
    else:
        var opposing_familiar = field.opposing_familiar_field().card
        if opposing_familiar != null:
            attack_that_familiar(opposing_familiar)
        else:
            print('DO NOT ATTACK A TOWER NOR A FAMILIAR, smtg is wrong')
    
    if not on_field():
        return
    
    # release animation
    $pos_tween.connect('tween_completed', self, 'attack_released')
    go_to(field.center_position(), 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)

func attack_that_familiar(familiar):
    familiar.receive_damage(at)
    receive_damage(familiar.at)

func receive_damage(amount):
    display_hint(amount, Color(1,0,0))
    hp -= amount
    check_for_death()

func attack_that_tower(tower):
    tower.receive_damage(at)
    exec_sabotage()

func attack_released(unused, unused2):
    $pos_tween.disconnect('tween_completed', self, 'attack_released')
    attacking = false

func check_for_death():
    if hp <= 0:
        die()

func die():
    cancel_attacking()
    var removed_from = remove_from_field()
    exec_deathrottle(removed_from)
    queue_free()
    