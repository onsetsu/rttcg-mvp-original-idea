extends Node

# ==============================================================================
# ================================= CARDS ======================================
# ==============================================================================

# ---------------------------------------------------------------------------------------------
# ---------------------------------------------------------------------------------------------
# Friendly Cards
# ---------------------------------------------------------------------------------------------
# ---------------------------------------------------------------------------------------------

func Duelist(card):
    card.key = 'Duelist'
    card.card_name = 'Duelist'
    card.text = 'Battlecry: Deal 1 Damage to opposing side.'
    card.type = 'familiar'
    card.at = 1
    card.hp = 1
    card.effects = [{
        trigger = 'battlecry',
        effect = ['shoot', 1],
    }]

func FormOfDragon(card):
    card.key = 'FormOfDragon'
    card.card_name = 'Form of Dragon'
    card.text = 'Your Familiars become 4/4 Dragons.'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    card.effect = 'transform_allies_into_dragons'

func DracoKnight(card):
    card.key = 'DracoKnight'
    card.card_name = 'Draco-Knight'
    card.text = 'Sabotage: Become a 4/4 Dragon.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 5
    card.sabotage = 'sabotage__become_a_dragon'

func Adventurer(card):
    card.key = 'Adventurer'
    card.card_name = 'Adventurer'
    card.text = ''
    card.type = 'familiar'
    card.at = 2
    card.hp = 3

func LineBreaker(card):
    card.key = 'LineBreaker'
    card.card_name = 'LineBreaker'
    card.text = 'Attacks immediately.'
    card.type = 'familiar'
    card.at = 4
    card.hp = 2
    card.battlecry = 'battlecry__attack_immediately'

func SplittingOoze(card):
    card.key = 'SplittingOoze'
    card.card_name = 'Splitting Ooze'
    card.text = 'Deathrottle: Summon a 1/2 Ooze. Add one to your hand.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 4
    card.deathrottle = 'deathrottle__split_into_1_2s'

func Ooze(card):
    card.generated = true
    
    card.key = 'Ooze'
    card.card_name = 'Ooze'
    card.text = ''
    card.type = 'familiar'
    card.at = 1
    card.hp = 2

func BladeDance(card):
    card.key = 'BladeDance'
    card.card_name = 'Blade Dance'
    card.text = 'Add 2 Shivs to your hand.'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    card.effect = 'create_2_shivs'

func HiredArm(card):
    card.key = 'HiredArm'
    card.card_name = 'Hired Arm'
    card.text = 'Battlecry: Create a Shiv.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 2
    card.battlecry = 'create_a_shiv'

# #design: too similar to knife juggler
func AsuraPriest(card):
    card.key = 'AsuraPriest'
    card.card_name = 'Asura Priest'
    card.text = 'Combo: Create a Shiv to your hand.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 4
    card.combo = 'combo__create_a_shiv'

func Shiv(card):
    card.generated = true
    
    card.key = 'Shiv'
    card.card_name = 'Shiv'
    card.text = 'Deal 2 damage.'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar_or_tower'
    card.effect = 'deal_2'

func Bumerang(card):
    card.key = 'Bumerang'
    card.card_name = 'Bumerang'
    card.text = 'Deal 2 damage. Combo: Return to hand.'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar_or_tower'
    card.effect = 'deal_2'
    card.combo = 'combo__deal_2_then_return_to_hand'

# Sorcery: Deal 3 Damage to an enemy familiar. Combo: And its tower.
func PierceThrough(card):
    card.key = 'PierceThrough'
    card.card_name = 'Pierce Through'
    card.text = 'Deal 3 Damage to a Familiar. Combo: And its Tower.'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar'
    card.effect = 'deal_3'
    card.combo = 'deal_3_then_deal_3_to_tower'

# Familiar: Combo: Attacks immediately.
func GoblinForerunner(card):
    card.key = 'GoblinForerunner'
    card.card_name = 'Goblin Forerunner'
    card.text = 'Combo: Attacks immediately.'
    card.type = 'familiar'
    card.at = 3
    card.hp = 2
    card.combo = 'combo__attacks_immediately'

# Sorcery: Give a Familiar +2/+2. Combo: affects all allies.
func BuyARound(card):
    card.key = 'BuyARound'
    card.card_name = 'Buy a Round'
    card.text = 'Give a Familiar +2/+2. Combo: Affect all allies.'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar_combo_not_required'
    card.effect = 'plus_2_plus_2'
    card.combo = 'combo__plus_2_plus_2_to_all'

func MoonRabbit(card):
    card.key = 'MoonRabbit'
    card.card_name = 'Moon Rabbit'
    card.text = 'Combo: Add a Moon Rabbit to your hand.'
    card.type = 'familiar'
    card.at = 1
    card.hp = 1
    card.combo = 'combo__copy_to_hand'

func Bard(card):
    card.key = 'Bard'
    card.card_name = 'Bard'
    card.text = 'Combo: Your Familiar get +1/+0.'
    card.type = 'familiar'
    card.at = 1
    card.hp = 4
    card.combo = 'combo__plus_1_plus_0_to_all'

func Multiply(card):
    card.key = 'Multiply'
    card.card_name = 'Multiply'
    card.text = 'Add 2 copies of target ally to your hand.'
    card.type = 'sorcery'
    card.targeting = 'targets_friendly_familiar'
    card.effect = 'copy_twice'

# Familiar: Combo: +2/+2.
func ToKu(card):
    card.key = 'ToKu'
    card.card_name = 'To-Ku'
    card.text = 'Combo: +2/+2.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 2
    card.combo = 'combo__plus_2_plus_2'

func Dragon(card):
    card.key = 'Dragon'
    card.card_name = 'Dragon'
    card.text = ''
    card.type = 'familiar'
    card.at = 4
    card.hp = 4
    card.targeting = null
    card.effect = null
    card.combo = null
    card.battlecry = null
    card.deathrottle = null
    card.sabotage = null
    card.attacks = true
    card.effect_damage_modifier = 0
    # #TODO: crystal forge's delayed ability still goes off indefinitely

func Fireball(card):
    card.key = 'Fireball'
    card.card_name = 'Fireball'
    card.text = 'Deal 3 Damage.'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar_or_tower'
    card.effect = 'deal_3'

func MeteorStrike(card):
    card.key = 'MeteorStrike'
    card.card_name = 'Meteor Strike'
    card.text = 'Deal 4 Damage to all enemy familiars.'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    card.effect = 'deal_4_all_enemy_familiars'

func IceWall(card):
    card.key = 'IceWall'
    card.card_name = 'Ice Wall'
    card.text = 'Doesn\'t attack.'
    card.type = 'familiar'
    card.at = 0
    card.hp = 10
    card.attacks = false

func PowerPotion(card):
    card.key = 'PowerPotion'
    card.card_name = 'Power Potion'
    card.text = 'Give a Familiar +3/+3.'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar'
    card.effect = 'plus_3_plus_3'

func Raid(card):
    card.key = 'Raid'
    card.card_name = 'Raid'
    card.text = 'Target Familiar gets +2/+2 and attacks.'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar'
    card.effect = 'plus_2_plus_2_then_attack'

func GoblinLooter(card):
    card.key = 'GoblinLooter'
    card.card_name = 'Goblin Looter'
    card.text = 'First time this sabotages: Draw a card.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 2
    card.sabotage = 'sabotage__draw_a_card'
    
func IdolOfGrowth(card):
    card.key = 'IdolOfGrowth'
    card.card_name = 'Idol of Growth'
    card.text = 'Inspired Familiar gets +2/+2.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 2
    card.inspire = 'inspire__plus_2_plus_2'
    
func IdolOfSpeed(card):
    card.key = 'IdolOfSpeed'
    card.card_name = 'Idol of Speed'
    card.text = 'Inspired Familiar attacks immediately.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 2
    card.inspire = 'inspire__attack_immediately'
    
func IdolOfMirror(card):
    card.key = 'IdolOfMirror'
    card.card_name = 'Idol of Mirror'
    card.text = 'Add a copy of inspired card to your hand.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 2
    card.inspire = 'inspire__copy_to_hand'
    
func IdolOfBlades(card):
    card.key = 'IdolOfBlades'
    card.card_name = 'Idol of Blades'
    card.text = 'Inspire: Add a Shiv to your hand.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 2
    card.inspire = 'inspire__create_a_shiv'
    
func IdolOfDragon(card):
    card.key = 'IdolOfDragon'
    card.card_name = 'Idol of Dragon'
    card.text = 'Inspired Familiar becomes a 4/4 Dragon.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 2
    card.inspire = 'inspire__become_a_dragon'
    
func FlashForward(card):
    card.key = 'FlashForward'
    card.card_name = 'Flash Forward'
    card.text = 'Deal 2 Damage. Inspired Familiar deal 2 Damage to opposing side.'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar_or_tower'
    card.effect = 'deal_2'
    card.inspire = 'inspire__familiar_deals_2_opposing_side'

func TheShepherd(card):
    card.key = 'TheShepherd'
    card.card_name = 'The Shepherd'
    card.text = 'Battlecry: Fill your board with exploding 1/1 Sheeps.'
    card.type = 'familiar'
    card.at = 1
    card.hp = 3
    card.battlecry = 'battlecry__fill_board_with_sheeps'

func Sheep(card):
    card.generated = true
    
    card.key = 'Sheep'
    card.card_name = 'Sheep'
    card.text = 'Deathrottle: Deal 1 Damage to opposing side.'
    card.type = 'familiar'
    card.at = 1
    card.hp = 1
    card.targeting = null
    card.effect = null
    card.combo = null
    card.battlecry = null
    card.deathrottle = 'deathrottle__deal_1_in_lane'
    card.sabotage = null
    card.attacks = true
    card.effect_damage_modifier = 0
    card.whenever = {}

func Phoenix(card):
    card.key = 'Phoenix'
    card.card_name = 'Phoenix'
    card.text = 'Deathrottle: Return to your hand as a 0/3 Egg.'
    card.type = 'familiar'
    card.at = 4
    card.hp = 2
    card.attacks = true
    card.deathrottle = 'deathrottle__great_phoenix'

func EggOfFlames(card):
    card.generated = true
    
    card.key = 'EggOfFlames'
    card.card_name = 'Egg of Flames'
    card.text = 'Doesn\'t attack. In 5 seconds: Becomes a Phoenix.'
    card.type = 'familiar'
    card.at = 0
    card.hp = 3
    card.attacks = false
    # TODO: when transformed by other means, the hatching is still there
    card.battlecry = 'battlecry__delay_5_become_a_phoenix'

func Scout(card):
    card.key = 'Scout'
    card.card_name = 'Scout'
    card.text = 'Draw a card for each enemy familiar.'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    card.effect = 'draw_one_for_each_enemy_familiar'

func Blacksmith(card):
    card.key = 'Blacksmith'
    card.card_name = 'Blacksmith'
    card.text = 'While approaching, Familiars you play gain +2/+2.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 4
    card.whenever = { play_card = 'own_familiar__plus_2_plus_2'}

func Cinderstorm(card):
    card.key = 'Cinderstorm'
    card.card_name = 'Cinderstorm'
    card.text = 'Deal 3 Damage. (6 if your approaching card is a sorcery.)'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar_or_tower'
    card.effect = 'deal_3_if_approching_sorcery_deal_6'

func Apprentice(card):
    card.key = 'Apprentice'
    card.card_name = 'Apprentice'
    card.text = 'Battlecry: Draw your approaching card.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 4
    card.battlecry = 'battlecry__draw_approaching_card'

func GiantSlug(card):
    card.key = 'GiantSlug'
    card.card_name = 'Giant Slug'
    card.text = 'Slow.'
    card.type = 'familiar'
    card.at = 5
    card.hp = 6
    card.slow = true

func QuickBlast(card):
    card.key = 'QuickBlast'
    card.card_name = 'Quick Blast'
    card.text = 'Deal 3 Damage. Haste.'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar'
    card.effect = 'deal_3'
    card.haste = true

func PillarOfFire(card):
    card.key = 'PillarOfFire'
    card.card_name = 'Pillar of Fire'
    card.text = 'Deal 4 Damage to everything in a lane.'
    card.type = 'sorcery'
    card.targeting = 'targets_field'
    card.effect = 'deal_4_all_in_lane'

func MorphingOoze(card):
    card.key = 'MorphingOoze'
    card.card_name = 'MorphingOoze'
    card.text = 'Click to gain +1/-1.'
    card.type = 'familiar'
    card.at = 0
    card.hp = 5
    card.ignition = 'ignition__plus_1_minus_1'

func SpellShaper(card):
    card.key = 'SpellShaper'
    card.card_name = 'Spell Shaper'
    card.text = 'Click: your leftmost card becomes a Fireball.'
    card.type = 'familiar'
    card.at = 1
    card.hp = 3
    card.ignition = 'ignition__leftmost_card_becomes_a_fireball'

func Bomber(card):
    card.key = 'Bomber'
    card.card_name = 'Bomber'
    card.text = 'Click to deal 2 Damage to everything in its lane.'
    card.type = 'familiar'
    card.at = 3
    card.hp = 5
    card.ignition = 'ignition__deal_2_all_in_lane'

func AdaptiveBrawler(card):
    card.key = 'AdaptiveBrawler'
    card.card_name = 'Adaptive Brawler'
    card.text = 'Battlecry: Swap HP with opposing familiar.'
    card.type = 'familiar'
    card.at = 3
    card.hp = 2
    card.battlecry = 'battlecry__swap_hp_opposing_familiar'
    
func Retreat(card):
    card.key = 'Retreat'
    card.card_name = 'Retreat'
    card.text = 'Return target friendly familiar to your hand.'
    card.type = 'sorcery'
    card.targeting = 'targets_friendly_familiar'
    card.effect = 'sorcery__return_to_hand'

func LoneChampion(card):
    card.key = 'LoneChampion'
    card.card_name = 'Lone Champion'
    card.text = 'Battlecry: Return all allies to your hand.'
    card.type = 'familiar'
    card.at = 3
    card.hp = 3
    card.battlecry = 'battlecry__return_others_to_hand'
    
func RightShift(card):
    card.key = 'RightShift'
    card.card_name = 'Right Shift'
    card.text = 'Move a familiar to the one lane to the right.'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar_with_empty_field_to_the_right'
    card.effect = 'sorcery__shift_to_right'

func Golem(card):
    card.key = 'Golem'
    card.card_name = 'Golem'
    card.text = 'Battlecry: Deal 2 Damage to all Familiars in other lanes.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 5
    card.battlecry = 'battlecry__deal_2_familiars_in_other_lanes'

func DragonHatchling(card):
    card.key = 'DragonHatchling'
    card.card_name = 'Dragon Hatchling'
    card.text = 'In 4 seconds: Becomes a 4/4 Dragon.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 3
    card.battlecry = 'battlecry__delay_4_become_a_dragon'

func Cleric(card):
    card.key = 'Cleric'
    card.card_name = 'Cleric'
    card.text = 'Every 2 seconds: Allies in other lanes get +0/+2.'
    card.type = 'familiar'
    card.at = 1
    card.hp = 4
    card.battlecry = 'battlecry__every_2_allies_other_lanes_plus_0_plus_2'

func Disarm(card):
    card.key = 'Disarm'
    card.card_name = 'Disarm'
    card.text = 'Target Familiar gets -4/-2.'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar'
    card.effect = 'sorcery__minus_4_minus_2'

func Languish(card):
    card.key = 'Languish'
    card.card_name = 'Languish'
    card.text = 'All Familiars get -4/-4. In 5 seconds: They get +4/+4.'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    card.effect = 'sorcery__all_minus_4_minus_4_delay_plus_4_plus_4'

func PowerOverwhelming(card):
    card.key = 'PowerOverwhelming'
    card.card_name = 'Power Overwhelming'
    card.text = 'Target Familiar gets +5/+5. In 8 seconds: It dies.'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar'
    card.effect = 'sorcery__plus_5_plus_5_delay_selfdestruct'

func FateWeaver(card):
    card.key = 'FateWeaver'
    card.card_name = 'Fate Weaver'
    card.text = 'Every 4 seconds: Draw a card, discard your leftmost.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 5
    card.battlecry = 'battlecry__every_4_draw_1_discard_leftmost'

func CreativeBurst(card):
    card.key = 'CreativeBurst'
    card.card_name = 'Creative Burst'
    card.text = 'Draw 3 cards. In 8 seconds: Discard them.'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    card.effect = 'sorcery__draw_3_delay_discard'
    
func CrystalForge(card):
    card.key = 'CrystalForge'
    card.card_name = 'Crystal Forge'
    card.text = 'Doesn\'t attack. Every 4 seconds: Create a Shiv.'
    card.type = 'familiar'
    card.at = 0
    card.hp = 6
    card.attacks = false
    card.battlecry = 'battlecry__every_4_create_a_shiv'

func DoubleShot(card):
    card.key = 'DoubleShot'
    card.card_name = 'Double Shot'
    card.text = 'Deal 3 Damage to a Familiar, now and in 3 seconds.'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar'
    card.effect = 'sorcery__deal_3_delay_deal_3'

func Catapult(card):
    card.key = 'Catapult'
    card.card_name = 'Catapult'
    card.text = 'Doesn\'t attack. Every 2 seconds: Deal 1 Damage to opposing side.'
    card.type = 'familiar'
    card.at = 0
    card.hp = 5
    card.attacks = false
    card.battlecry = 'battlecry__every_2_deal_1_opposing_side'

func Sapling(card):
    card.key = 'Sapling'
    card.card_name = 'Sapling'
    card.text = 'Become a 4/6 Treant after 8 seconds in hand.'
    card.type = 'familiar'
    card.at = 0
    card.hp = 2
    card.whenever = { add_to_hand = 'in_hand__delay_8_transform__to_treant'}

func Treant(card):
    card.generated = true
    
    card.key = 'Treant'
    card.card_name = 'Treant'
    card.text = ''
    card.type = 'familiar'
    card.at = 4
    card.hp = 6

func Poison(card):
    card.key = 'Poison'
    card.card_name = 'Poison'
    card.text = 'Target familiar takes 1 damage every 1.5 seconds.'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar'
    card.effect = 'sorcery__deal_1_every_1_1_2_seconds'

func FlameArrow(card):
    card.key = 'FlameArrow'
    card.card_name = 'Flame Arrow'
    card.text = 'Deal 5 Damage. Discard after 2 seconds.'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar'
    card.effect = 'sorcery__deal_5'
    card.whenever = { add_to_hand = 'in_hand__delay_5_discard'}

func Carpenter(card):
    card.key = 'Carpenter'
    card.card_name = 'Carpenter'
    card.text = 'Battlecry: Heal 5 HP to guarded Tower.'
    card.type = 'familiar'
    card.at = 3
    card.hp = 4
    card.battlecry = 'battlecry__heal_5_guarded_tower'

func LightningBolt(card):
    card.key = 'LightningBolt'
    card.card_name = 'Lightning Bolt'
    card.text = 'Deal 3 Damage. Charge 5: Deal 6 Damage instead.'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar_or_tower'
    card.effect = 'sorcery__deal_3_charged_6'
    card.charge_time = 5

func InvertedRager(card):
    card.key = 'InvertedRager'
    card.card_name = 'Inverted Rager'
    card.text = 'Charge 3: Swap its AT and HP.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 5
    card.battlecry = 'battlecry__charged_swap_at_hp'
    card.charge_time = 3

func Brawler(card):
    card.key = 'Brawler'
    card.card_name = 'Brawler'
    card.text = 'Attacks Immediately. Charge 3: Gain +3/+3 instead.'
    card.type = 'familiar'
    card.at = 3
    card.hp = 1
    card.battlecry = 'battlecry__attacks_immediately_charged_instead_plus_3_plus_3'
    card.charge_time = 3

func InfiniteBlades(card):
    card.key = 'InfiniteBlades'
    card.card_name = 'Infinite Blades'
    card.text = 'Give a Familiar +2/+2. Charge 4: Add this to your hand.'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar'
    card.effect = 'sorcery__plus_2_plus_2_charged_return_to_hand'
    card.charge_time = 4

func UndeadHorde(card):
    card.key = 'UndeadHorde'
    card.card_name = 'UndeadHorde'
    card.text = 'Charge 5: Fill your board with copies of this.'
    card.type = 'familiar'
    card.at = 3
    card.hp = 4
    card.battlecry = 'battlecry__charged_fill_your_board_with_copies_of_this'
    card.charge_time = 5

func CollectiveStrike(card):
    card.key = 'CollectiveStrike'
    card.card_name = 'Collective Strike'
    card.text = 'Discard your hand. Deal 3 Damage for each card discarded to all enemy familiars.'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    card.effect = 'sorcery__discard_hand_deal_3_for_each_discarded'

func SpellEater(card):
    card.key = 'SpellEater'
    card.card_name = 'Spell Eater'
    card.text = 'Battlecry: If your opponent\'s approaching card in a sorcery: Gain +3/+3.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 2
    card.battlecry ='battlecry__opponents_card_is_sorcery_plus_3_plus_3'

func ShadowWord(card):
    card.key = 'ShadowWord'
    card.card_name = 'Shadow Word'
    card.text = 'Destroy all Familiars with 4 AT or HP.'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    card.effect = 'sorcery__destroy_all_familiars_with_4_at_or_hp'

func Crumble(card):
    card.key = 'Crumble'
    card.card_name = 'Crumble'
    card.text = 'Deal 7 Damage to enemy tower with highest HP.'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    card.effect = 'sorcery__deal_7_to_enemy_tower_with_highest_hp'

func CuriousExperimenter(card):
    card.key = 'CuriousExperimenter'
    card.card_name = 'Curious Experimenter'
    card.text = 'Battlecry: Create a random sorcery.'
    card.type = 'familiar'
    card.at = 3
    card.hp = 2
    card.battlecry ='battlecry__create_random_spell'

func Djinn(card):
    card.key = 'Djinn'
    card.card_name = 'Djinn'
    card.text = 'Deathrottle: If you have no Lamp: Create a Lamp.'
    card.type = 'familiar'
    card.at = 3
    card.hp = 3
    card.deathrottle ='deathrottle__if_no_lamp_create_a_lamp'

func Lamp(card):
    card.generated = true
    
    card.key = 'Lamp'
    card.card_name = 'Lamp'
    card.text = 'Charge 3: Create a Djinn.'
    card.type = 'sorcery'
    card.targeting = 'no_target_required_and_is_charged'
    card.effect = 'sorcery__if_charged_create_a_djinn'
    card.charge_time = 3

func ArcaneGatling(card):
    card.key = 'ArcaneGatling'
    card.card_name = 'Arcane Gatling'
    card.text = 'Deal 5 Damage to random enemies over 2 seconds.'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    card.effect = 'sorcery__if_charged_deal_1_damage_each_half_second'
    card.enchantment_duration = 2

func Defile(card):
    card.key = 'Defile'
    card.card_name = 'Defile'
    card.text = 'Deal 1 Damage to all Familiars. If any die: add this to your hand.'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    card.effect = 'sorcery__deal_1_to_all_if_any_dies_return_to_hand'

func WarChant(card):
    card.key = 'WarChant'
    card.card_name = 'War Chant'
    card.text = 'For 6 seconds: Familiars you play gain +1/+1.'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    card.enchantment_duration = 6
    card.whenever = { play_card = 'active_enchantment__plus_1_plus_1_to_friendly_familiars'}

func ResonanceOrb(card):
    card.key = 'ResonanceOrb'
    card.card_name = 'Resonance Orb'
    card.text = 'For 10 seconds: Whenever you play a card: Deal 1 Damage to all enemy familiars.'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    card.enchantment_duration = 10
    card.whenever = { play_card = 'active_enchantment__deal_1_to_all_enemy_familiars'}

func MirrorImage(card):
    card.key = 'MirrorImage'
    card.card_name = 'Mirror Image'
    card.text = 'Battlecry: Copy opposing familiar\'s stats.'
    card.type = 'familiar'
    card.at = 1
    card.hp = 1
    card.battlecry ='battlecry__copy_opposing_familiars_stats'

func PlanAhead(card):
    card.key = 'PlanAhead'
    card.card_name = 'Plan Ahead'
    card.text = 'In 4 seconds: Your familiars gain +2/+2.'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    card.enchantment_duration = 4
    card.enchantment_cease_effect = 'enchantment_cease__your_familiars_gain_plus_2_plus_2'

func HealingWave(card):
    card.key = 'HealingWave'
    card.card_name = 'Healing Wave'
    card.text = 'Your familiars gain +0/+4.'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    card.effect = 'sorcery__your_familiars_gain_plus_0_plus_4'

func ShadeArmor(card):
    card.key = 'ShadeArmor'
    card.card_name = 'Shade Armor'
    card.text = 'Transform allied familiar into a 2/4 Black Knight.'
    card.type = 'sorcery'
    card.targeting = 'targets_friendly_familiar'
    card.effect = 'sorcery__transform_into_fafnir_knight'

func BlackKnight(card):
    card.generated = true
    
    card.key = 'BlackKnight'
    card.card_name = 'Black Knight'
    card.text = 'Deathrottle: Resummon transformed familiar.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 4
    card.attacks = true
    card.effect_damage_modifier = 0
    card.deathrottle ='deathrottle__fafnir_knight_resummon_transformed_familiar'

func Reiterate(card):
    card.key = 'Reiterate'
    card.card_name = 'Reiterate'
    card.text = 'For 5 seconds: Draw a card whenever you play a sorcery.'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    card.enchantment_duration = 5
    card.whenever = { play_card = 'active_enchantment__draw_1_if_played_a_sorcery'}

func Shield(card):
    card.generated = true
    
    card.key = 'Shield'
    card.card_name = 'Shield'
    card.text = 'Give a Familiar +0/+3, or summon a 0/3 Plate Shield.'
    card.type = 'sorcery'
    card.targeting = 'targets_field'
    card.effect = 'sorcery__plus_0_plus_3_or_summon_a_0_3'

func PlateShield(card):
    card.generated = true
    
    card.key = 'PlateShield'
    card.card_name = 'Plate Shield'
    card.text = 'Doesn\'t attack.'
    card.type = 'familiar'
    card.at = 0
    card.hp = 3
    card.attacks = false

func ShieldMage(card):
    card.key = 'ShieldMage'
    card.card_name = 'Shield Mage'
    card.text = 'Battlecry and Deathrottle: Create a Shield.'
    card.type = 'familiar'
    card.at = 3
    card.hp = 1
    card.battlecry ='battlecry__create_a_shield'
    card.deathrottle ='deathrottle__create_a_shield'

func SagittariusShot(card):
    card.key = 'SagittariusShot'
    card.card_name = 'Sagittarius Shot'
    card.text = 'In 5 seconds: Deal 5 damage to familiars with highest HP.'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    card.enchantment_duration = 5
    card.enchantment_cease_effect = 'enchantment_cease__deal_5_to_highest_hp_familiars'

func Burst(card):
    card.key = 'Burst'
    card.card_name = 'Burst'
    card.text = 'Create copies of the next 2 sorceries you play.'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    card.enchantment_duration = -1
    card.whenever = { play_card = 'active_enchantment__twice_copy_own_sorcery'}

func Tactician(card):
    card.key = 'Tactician'
    card.card_name = 'Tactician'
    card.text = 'Battlecry: On Middle Lane: +2/+0. Otherwise: +0+2.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 2
    card.battlecry ='battlecry__middle_lane_plus_2_at_others_plus_2_hp'

func ShieldFormOoze(card):
    card.key = 'ShieldFormOoze'
    card.card_name = 'Shield-Form Ooze'
    card.text = 'Click to become a 4/1 Sword-Form.'
    card.type = 'familiar'
    card.at = 1
    card.hp = 4
    card.ignition = 'ignition__become_sword_form'

func SwordFormOoze(card):
    card.generated = true
    
    card.key = 'SwordFormOoze'
    card.card_name = 'Sword-Form Ooze'
    card.text = 'Click to become a 1/4 Shield-Form.'
    card.type = 'familiar'
    card.at = 4
    card.hp = 1
    card.ignition = 'ignition__become_shield_form'

func UnitedAssault(card):
    card.key = 'UnitedAssault'
    card.card_name = 'United Assault'
    card.text = 'Your familiars deal damage equal to their AT to opposing side.'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    card.effect = 'sorcery__friendly_familiars_deal_damage_to_opposing_side'

func Arcanist(card):
    card.key = 'Arcanist'
    card.card_name = 'Arcanist'
    card.text = 'Effect Damage +1.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 2
    card.effect_damage_modifier = +1

func Concentrate(card):
    card.key = 'Concentrate'
    card.card_name = 'Concentrate'
    card.text = 'Create a Shiv. Effect Damage +1 for 5 seconds.'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    card.effect = 'sorcery__create_a_shiv'
    card.enchantment_duration = 5
    card.effect_damage_modifier = +1

func TheMaw(card):
    card.key = 'TheMaw'
    card.card_name = 'The Maw'
    card.text = 'Battlecry: Discard your hand. Gain +1/+1 for each card. Deathrottle: Return discarded cards.'
    card.type = 'familiar'
    card.at = 1
    card.hp = 1
    card.battlecry = 'battlecry__discard_your_hand_gain_plus_1_plus_1_each'
    card.deathrottle = 'deathrottle__return_discarded_cards'

func FlankCrusher(card):
    card.key = 'FlankCrusher'
    card.card_name = 'Flank Crusher'
    card.text = 'Battlecry: +2/+2 if played to left lane.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 2
    card.battlecry = 'battlecry__if_left_lane_plus_2_plus_2'

func Well(card):
    card.key = 'Well'
    card.card_name = 'Well'
    card.text = 'Draw 2 cards. Discard your leftmost card.'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    card.effect = 'sorcery__draw_2_discard_leftmost'

func Strategist(card):
    card.key = 'Strategist'
    card.card_name = 'Strategist'
    card.text = 'Battlecry: Gain +1/+1 for each other familiar.'
    card.type = 'familiar'
    card.at = 1
    card.hp = 1
    card.battlecry = 'battlecry__plus_1_plus_1_for_other_familiars'

func Negate(card):
    card.key = 'Negate'
    card.card_name = 'Negate'
    card.text = 'Discard opponent\'s approaching card.'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    card.effect = 'sorcery__discard_opponents_approaching_card'

func Smash(card):
    card.key = 'Smash'
    card.card_name = 'Smash'
    card.text = 'Deal 1 Damage. (hold to power up)'
    card.text_fn = 'text_fn__deal_x_damage'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar_or_tower'
    
    card.effect = 'sorcery__deal_1_power_up'
    card.effect_store = {
        charges = 1,
        power_up_time = 2,
        power_up_callback = 'power_up_tick',
        power_up_label = '+1 damage'
    }
    card.on_drag_start = 'start_power_up_timer'
    card.on_snap_back = 'reset_charges_remove_power_up_timer'
    
func ChargedGrowth(card):
    card.key = 'ChargedGrowth'
    card.card_name = 'Charged Growth'
    card.text = 'Give a Familiar +1/+1. (hold to power up)'
    card.text_fn = 'text_fn__plus_x_plus_x'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar'
    
    card.effect = 'sorcery__plus_1_plus_1_power_up'
    card.effect_store = {
        charges = 1,
        power_up_time = 2,
        power_up_callback = 'power_up_tick',
        power_up_label = '+1/+1'
    }
    card.on_drag_start = 'start_power_up_timer'
    card.on_snap_back = 'reset_charges_remove_power_up_timer'
    
func ChargedBlessing(card):
    card.key = 'ChargedBlessing'
    card.card_name = 'Charged Blessing'
    card.text = 'Heal 1 HP to all your towers. (hold to power up)'
    card.text_fn = 'text_fn__heal_x_friendly_towers'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    
    card.effect = 'sorcery__heal_1_all_friendly_towers_power_up'
    card.effect_store = {
        charges = 1,
        power_up_time = 2,
        power_up_callback = 'power_up_tick',
        power_up_label = '+1 heal'
    }
    card.on_drag_start = 'start_power_up_timer'
    card.on_snap_back = 'reset_charges_remove_power_up_timer'
    
func ChargedInsight(card):
    card.key = 'ChargedInsight'
    card.card_name = 'Charged Insight'
    card.text = 'Draw 1 card. (hold to power up)'
    card.text_fn = 'text_fn__draw_x_cards'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    
    card.effect = 'sorcery__draw_1_card_power_up'
    card.effect_store = {
        charges = 1,
        power_up_time = 2.5,
        power_up_callback = 'power_up_tick',
        power_up_label = '+1 card'
    }
    card.on_drag_start = 'start_power_up_timer'
    card.on_snap_back = 'reset_charges_remove_power_up_timer'
    
func ChargedKnife(card):
    card.key = 'ChargedKnife'
    card.card_name = 'Charged Knife'
    card.text = 'Create 1 Shiv. (hold to power up)'
    card.text_fn = 'text_fn__create_x_shivs'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    
    card.effect = 'sorcery__create_1_shiv_power_up'
    card.effect_store = {
        charges = 1,
        power_up_time = 2,
        power_up_callback = 'power_up_tick',
        power_up_label = '+1 Shiv'
    }
    card.on_drag_start = 'start_power_up_timer'
    card.on_snap_back = 'reset_charges_remove_power_up_timer'
    
func BattleBot(card):
    card.key = 'BattleBot'
    card.card_name = 'BattleBot'
    card.text = '(hold to power up)'
    card.type = 'familiar'
    card.at = 1
    card.hp = 1
    
    card.effect_store = {
        charges = 1,
        power_up_time = 2,
        power_up_callback = 'on_charges_timer_tick_charged_beast',
        power_up_label = '+1/+1'
    }
    card.on_drag_start = 'start_power_up_timer'
    card.on_snap_back = 'snap_back__charge_beast'
    
func Gardener(card):
    card.key = 'Gardener'
    card.card_name = 'Gardener'
    card.text = 'Battlecry: Familiars in your hand gain +1/+1.'
    card.type = 'familiar'
    card.at = 1
    card.hp = 4
    card.effects = [{
        trigger = 'battlecry',
        effect = ['hand_buff_all', 1, 1],
    }]

func ForgottenSoul(card):
    card.key = 'ForgottenSoul'
    card.card_name = 'Forgotten Soul'
    card.text = 'Cannot be damaged. Gain -1/-1 every 4 seconds.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 2
    card.no_damage = true
    card.effects = [{
        trigger = 'battlecry',
        effect = ['battlecry__every_4_minus_1_minus_1'],
    }]


# ---------------------------------------------------------------------------------------------
# ---------------------------------------------------------------------------------------------
# Enemy Cards
# ---------------------------------------------------------------------------------------------
# ---------------------------------------------------------------------------------------------

func Skeleton(card):
    card.deck = 'enemy'
    
    card.key = 'Skeleton'
    card.card_name = 'Skeleton'
    card.text = ''
    card.type = 'familiar'
    card.at = 3
    card.hp = 2
    
func SkeletonElite(card):
    card.deck = 'enemy'
    
    card.key = 'SkeletonElite'
    card.card_name = 'Skeleton Elite'
    card.text = ''
    card.type = 'familiar'
    card.at = 4
    card.hp = 3

func Kirin(card):
    card.deck = 'enemy'
    
    card.key = 'Kirin'
    card.card_name = 'Kirin'
    card.text = 'Battlecry: Deal 4 Damage to opposing side.'
    card.type = 'familiar'
    card.at = 10
    card.hp = 10
    card.battlecry = 'battlecry__deal_4_in_lane'

func BatteringRam(card):
    card.deck = 'enemy'
    
    card.key = 'BatteringRam'
    card.card_name = 'Battering Ram'
    card.text = 'Battlecry: Deal 4 Damage to opposing side.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 6
    card.battlecry = 'battlecry__deal_4_in_lane'

func Cultist(card):
    card.deck = 'enemy'
    
    card.key = 'Cultist'
    card.card_name = 'Cultist'
    card.text = 'Deathrottle: Summon a Skeleton.'
    card.type = 'familiar'
    card.at = 1
    card.hp = 3
    card.deathrottle = 'deathrottle__summon_a_skeleton'

func Halberd(card):
    card.deck = 'enemy'
    
    card.key = 'Halberd'
    card.card_name = 'Halberd'
    card.text = 'Target Familiar gets +3/+3 and attacks.'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar'
    card.effect = 'plus_3_plus_3_then_attack'

func RockThrow(card):
    card.deck = 'enemy'
    
    card.key = 'RockThrow'
    card.card_name = 'Rock Throw'
    card.text = 'Deal 5 Damage to a familiar.'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar'
    card.effect = 'deal_5'

func ManaSapling(card):
    card.deck = 'enemy'
    
    card.key = 'ManaSapling'
    card.card_name = 'Mana Sapling'
    card.text = 'Whenever player plays a card, gain +1/+1.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 4
    card.whenever = { play_card = 'on_field__plus_1_plus_1'}

func Juggernaut(card):
    card.deck = 'enemy'
    
    card.key = 'Juggernaut'
    card.card_name = 'Juggernaut'
    card.text = 'Whenever this attacks, gain +2/+0.'
    card.type = 'familiar'
    card.at = 1
    card.hp = 4
    card.whenever = { attack = 'this__plus_2_plus_0'}

func Counterspell(card): # Rename to Disarm?
    card.deck = 'enemy'
    
    card.key = 'Counterspell'
    card.card_name = 'Counterspell'
    card.text = 'Opponent discards all Sorceries.'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    card.effect = 'opponent_discards_all_sorceries'

func BearTrap(card):
    card.deck = 'enemy'
    
    card.key = 'BearTrap'
    card.card_name = 'Bear Trap'
    card.text = 'Deal 4 Damage. Approching: Cast on first played familiar played.'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar_or_tower'
    card.effect = 'deal_4'
    card.whenever = { play_card = 'approaching__cast_on_familiar'}

func WoodSpider(card):
    card.deck = 'enemy'
    
    card.key = 'WoodSpider'
    card.card_name = 'Wood Spider'
    card.text = 'Approching: Deal 2 Damage to played familiars.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 3
    card.whenever = { play_card = 'approaching__deal_2_to_familiar'}

func Saboteur(card):
    card.deck = 'enemy'
    
    card.key = 'Saboteur'
    card.card_name = 'Saboteur'
    card.text = 'Battlecry: Discard leftmost enemy card.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 4
    card.battlecry = 'battlecry__opponent_discard_leftmost'

func FlyingBoar(card):
    card.deck = 'enemy'
    
    card.key = 'FlyingBoar'
    card.card_name = 'FlyingBoar'
    card.text = 'Haste.'
    card.type = 'familiar'
    card.at = 3
    card.hp = 3
    card.haste = true

func PlagueRats(card):
    card.deck = 'enemy'
    
    card.key = 'PlagueRats'
    card.card_name = 'Plague Rats'
    card.text = '+1/+1 for each Plague Rats played before.'
    card.type = 'familiar'
    card.at = 1
    card.hp = 1
    
    card.battlecry = 'battlecry__rat_played'
    var Game = get_tree().get_root().get_node('Game')
    if Game != null:
        var num_rats = Game.effect_store.num_rats
        card.at += num_rats
        card.hp += num_rats

func ShapeThief(card):
    card.deck = 'enemy'
    
    card.key = 'ShapeThief'
    card.card_name = 'Shape Thief'
    card.text = 'Battlecry: Discard an enemy familiar. Copy its stats.'
    card.type = 'familiar'
    card.at = 1
    card.hp = 1
    card.battlecry = 'battlecry__opponent_discards_familiar_gain_its_stats'

func MiningBot(card):
    card.deck = 'enemy'
    
    card.key = 'MiningBot'
    card.card_name = 'Mining Bot'
    card.text = 'Battlecry: Fill your board with 1/1 Mines.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 2
    card.battlecry = 'battlecry__fill_your_board_with_1_1_bombs'

# #Design
# they explode in 3-4 seconds (before next approaching card)
# should they deal damage on deathrottle, too?
# -> explode in 4 seconds. Deathrottle: deal 6 in lane.
func ExplosiveMine(card):
    card.generated = true
    
    card.deck = 'enemy'
    
    card.key = 'ExplosiveMine'
    card.card_name = 'Explosive Mine'
    card.text = 'In 3 Seconds: Selfdestruct to deal 5 Damage in its lane.'
    card.type = 'familiar'
    card.at = 1
    card.hp = 1
    card.attacks = false

func WolfRaider(card):
    card.deck = 'enemy'
    
    card.key = 'WolfRaider'
    card.card_name = 'Wolf Raider'
    card.text = 'Haste. Attacks immediately.'
    card.type = 'familiar'
    card.at = 3
    card.hp = 1
    card.haste = true
    card.battlecry = 'battlecry__attack_immediately'

func PackWolf(card):
    card.deck = 'enemy'
    
    card.key = 'PackWolf'
    card.card_name = 'Pack Wolf'
    card.text = 'Battlecry: Summon a 2/2 Pack Wolf.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 2
    card.battlecry = 'battlecry__summon_pack_wolf'

func SewerDweller(card):
    card.deck = 'enemy'
    
    card.key = 'SewerDweller'
    card.card_name = 'Sewer Dweller'
    card.text = 'Slow.'
    card.type = 'familiar'
    card.at = 4
    card.hp = 5
    card.slow = true

func SpikedWall(card):
    card.deck = 'enemy'
    
    card.key = 'SpikedWall'
    card.card_name = 'Spiked Wall'
    card.text = 'Doesn\'t attack.'
    card.type = 'familiar'
    card.at = 3
    card.hp = 6
    card.attacks = false

func StoneGiant(card):
    card.deck = 'enemy'
    
    card.key = 'StoneGiant'
    card.card_name = 'Stone Giant'
    card.text = 'Whenever enemy plays a card: gain -1/-1.'
    card.type = 'familiar'
    card.at = 6
    card.hp = 6
    card.whenever = { play_card = 'opponent__minus_1_minus_1'}

func Crawler(card):
    card.deck = 'enemy'
    
    card.key = 'Crawler'
    card.card_name = 'Crawler'
    card.text = ''
    card.type = 'familiar'
    card.at = 5
    card.hp = 1

func Slime4(card):
    card.deck = 'enemy'
    
    card.key = 'Slime4'
    card.card_name = 'Giant Slime'
    card.text = 'Deathrottle: Summon 2 2/2 Slimes.'
    card.type = 'familiar'
    card.at = 4
    card.hp = 4
    card.deathrottle = 'deathrottle__summon_2_2_2_slimes'

func Slime2(card):
    card.generated = true
    
    card.deck = 'enemy'
    
    card.key = 'Slime2'
    card.card_name = 'Slime'
    card.text = 'Deathrottle: Summon 2 1/1 Slimes.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 2
    card.deathrottle = 'deathrottle__summon_2_1_1_slimes'

func Slime1(card):
    card.generated = true
    
    card.deck = 'enemy'
    
    card.key = 'Slime1'
    card.card_name = 'Tiny Slime'
    card.text = ''
    card.type = 'familiar'
    card.at = 1
    card.hp = 1

func SpiderKing(card):
    card.deck = 'enemy'
    
    card.key = 'SpiderKing'
    card.card_name = 'Spider King'
    card.text = 'Battlecry: Deal 2 Damage to other familiars.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 4
    card.battlecry = 'battlecry__deal_2_to_other_familiars'

func ScytheCrawler(card):
    card.deck = 'enemy'
    
    card.key = 'ScytheCrawler'
    card.card_name = 'Scythe Crawler'
    card.text = 'In 4 seconds: Gain +2/+2.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 3
    card.battlecry = 'battlecry__delay_4_plus_2_plus_2'

func Rampart(card):
    card.deck = 'enemy'
    
    card.key = 'Rampart'
    card.card_name = 'Rampart'
    card.text = 'Doesn\'t attack.'
    card.type = 'familiar'
    card.at = 0
    card.hp = 7
    card.attacks = false
    #card.battlecry = 'battlecry__delay_4_plus_2_plus_2'

func IceWallEnemy(card):
    card.deck = 'enemy'
    
    card.key = 'IceWallEnemy'
    card.card_name = 'Ice Wall'
    card.text = 'Doesn\'t attack.'
    card.type = 'familiar'
    card.at = 0
    card.hp = 10
    card.attacks = false
    #card.battlecry = 'battlecry__delay_4_plus_2_plus_2'

func WatchTower(card):
    card.deck = 'enemy'
    
    card.key = 'WatchTower'
    card.card_name = 'Watch Tower'
    card.text = 'Doesn\'t attack. When opponent plays a card: Shoot 2.'
    card.type = 'familiar'
    card.at = 0
    card.hp = 7
    card.attacks = false
    #card.battlecry = 'battlecry__delay_4_plus_2_plus_2'
    card.whenever = { play_card = 'opponent__shoot_2'}

func AwakeTheWalls(card):
    card.deck = 'enemy'
    
    card.key = 'AwakeTheWalls'
    card.card_name = 'Awake The Walls'
    card.text = 'All AIs shoot with their HP.'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    card.effect = 'sorcery__ai_familiars_deal_damage_to_opposing_side_equal_to_hp'

func IntoTheVoid(card):
    card.deck = 'enemy'
    
    card.key = 'IntoTheVoid'
    card.card_name = 'IntoTheVoid'
    card.text = 'Cannot be damaged. When player plays a card: +1/-1.'
    card.type = 'familiar'
    card.at = 0
    card.hp = 5
    card.no_damage = true
    card.whenever = { play_card = 'opponent__plus_1_minus_1'}

func CopyCat(card):
    card.deck = 'enemy'
    
    card.key = 'CopyCat'
    card.card_name = 'CopyCat'
    card.text = 'Whenever player plays a familiar: Copy its stats.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 3
    card.whenever = { play_card = 'opponent__copy_stats'}

func EvilShepherd(card):
    card.deck = 'enemy'
    
    card.key = 'EvilShepherd'
    card.card_name = 'Evil Shepherd'
    card.text = 'Whenever player plays a card: Player\' approaching card becomes a Sheep.'
    card.type = 'familiar'
    card.at = 2
    card.hp = 4
    card.whenever = { play_card = 'opponent__approaching_player_card_becomes_sheep'}
