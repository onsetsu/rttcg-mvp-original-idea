extends Node

func apply_onto(name, card):
    funcref(self, name).call_func(card)

# ==============================================================================
# ================================= CARDS ======================================
# ==============================================================================

# Friendly Cards
# ---------------------------------------------------------------------------------------------

func ElvenArcher(card):
    card.key = 'ElvenArcher'
    card.card_name = 'Elven Archer'
    card.text = 'Battlecry: Deal 2 Damage to opposing side.'
    card.element = 'earth'
    card.type = 'familiar'
    card.at = 2
    card.hp = 2
    card.battlecry = 'battlecry__deal_2_in_lane'
    
func FormOfDragon(card):
    card.key = 'FormOfDragon'
    card.card_name = 'Form of Dragon'
    card.text = 'Your Familiars become 5/5 Dragons.'
    card.element = 'fire'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    card.effect = 'transform_allies_into_dragons'

func DracoKnight(card):
    card.key = 'DracoKnight'
    card.card_name = 'Draco-Knight'
    card.text = 'Sabotage: Become a 5/5 Dragon.'
    card.element = 'fire'
    card.type = 'familiar'
    card.at = 2
    card.hp = 5
    card.sabotage = 'sabotage__become_a_dragon'

func Flamekin(card):
    card.key = 'Flamekin'
    card.card_name = 'Flamekin'
    card.text = ''
    card.element = 'fire'
    card.type = 'familiar'
    card.at = 3
    card.hp = 4

func Anafenza(card):
    card.key = 'Anafenza'
    card.card_name = 'Anafenza'
    card.text = 'Attacks immediately.'
    card.element = 'earth'
    card.type = 'familiar'
    card.at = 5
    card.hp = 3
    card.battlecry = 'battlecry__attack_immediately'

func SplittingOoze(card):
    card.key = 'SplittingOoze'
    card.card_name = 'Splitting Ooze'
    card.text = 'Deathrottle: Summon a 2/4 Ooze. Add one to your hand.'
    card.element = 'water'
    card.type = 'familiar'
    card.at = 4
    card.hp = 8
    card.deathrottle = 'deathrottle__split_into_2_4s'

func Ooze(card):
    card.key = 'Ooze'
    card.card_name = 'Ooze'
    card.text = ''
    card.element = 'water'
    card.type = 'familiar'
    card.at = 2
    card.hp = 4

func BladeDance(card):
    card.key = 'BladeDance'
    card.card_name = 'Blade Dance'
    card.text = 'Add 2 Shivs to your hand.'
    card.element = 'earth'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    card.effect = 'create_2_shivs'

func KnifeJuggler(card):
    card.key = 'KnifeJuggler'
    card.card_name = 'Knife Juggler'
    card.text = 'Battlecry: Add a Shiv to your hand.'
    card.element = 'earth'
    card.type = 'familiar'
    card.at = 3
    card.hp = 4
    card.battlecry = 'create_a_shiv'

# #design: too similar to knife juggler
func AsuraPriest(card):
    card.key = 'AsuraPriest'
    card.card_name = 'Asura Priest'
    card.text = 'Combo: Add a Shiv to your hand.'
    card.element = 'earth'
    card.type = 'familiar'
    card.at = 2
    card.hp = 4
    card.combo = 'combo__create_a_shiv'

func Shiv(card):
    card.key = 'Shiv'
    card.card_name = 'Shiv'
    card.text = 'Deal 3 damage.'
    card.element = 'earth'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar_or_tower'
    card.effect = 'deal_3'

func Bumerang(card):
    card.key = 'Bumerang'
    card.card_name = 'Bumerang'
    card.text = 'Deal 2 damage. Combo: Return to hand.'
    card.element = 'earth'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar_or_tower'
    card.effect = 'deal_2'
    card.combo = 'combo__deal_2_then_return_to_hand'

# Sorcery: Deal 3 Damage to an enemy familiar. Combo: And its tower.
func PierceThrough(card):
    card.key = 'PierceThrough'
    card.card_name = 'Pierce Through'
    card.text = 'Deal 3 Damage to a Familiar. Combo: And its Tower.'
    card.element = 'fire'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar'
    card.effect = 'deal_3'
    card.combo = 'deal_3_then_deal_3_to_tower'

# Familiar: Combo: Attacks immediately.
func GoblinForerunner(card):
    card.key = 'GoblinForerunner'
    card.card_name = 'Goblin Forerunner'
    card.text = 'Combo: Attacks immediately.'
    card.element = 'earth'
    card.type = 'familiar'
    card.at = 3
    card.hp = 2
    card.combo = 'combo__attacks_immediately'

# Sorcery: Give a Familiar +2/+2. Combo: affects all allies.
func SharedGrowth(card):
    card.key = 'SharedGrowth'
    card.card_name = 'Shared Growth'
    card.text = 'Give a Familiar +2/+2. Combo: Affect all allies.'
    card.element = 'earth'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar_combo_not_required'
    card.effect = 'plus_2_plus_2'
    card.combo = 'combo__plus_2_plus_2_to_all'

func MoonRabbit(card):
    card.key = 'MoonRabbit'
    card.card_name = 'Moon Rabbit'
    card.text = 'Combo: Add a Moon Rabbit to your hand.'
    card.element = 'earth'
    card.type = 'familiar'
    card.at = 1
    card.hp = 3
    card.combo = 'combo__copy_to_hand'

func Bard(card):
    card.key = 'Bard'
    card.card_name = 'Bard'
    card.text = 'Combo: Your Familiar get +1/+0.'
    card.element = 'earth'
    card.type = 'familiar'
    card.at = 1
    card.hp = 4
    card.combo = 'combo__plus_1_plus_0_to_all'

func Multiply(card):
    card.key = 'Multiply'
    card.card_name = 'Multiply'
    card.text = 'Add 2 copies of target ally to your hand.'
    card.element = 'water'
    card.type = 'sorcery'
    card.targeting = 'targets_friendly_familiar'
    card.effect = 'copy_twice'

# Familiar: Combo: +2/+2.
func ComboFighter(card):
    card.key = 'ComboFighter'
    card.card_name = 'Combo Fighter'
    card.text = 'Combo: +2/+2.'
    card.element = 'earth'
    card.type = 'familiar'
    card.at = 2
    card.hp = 3
    card.combo = 'combo__plus_2_plus_2'

func Dragon(card):
    card.key = 'Dragon'
    card.card_name = 'Dragon'
    card.text = ''
    card.element = 'fire'
    card.type = 'familiar'
    card.at = 5
    card.hp = 5
    card.targeting = null
    card.effect = null
    card.combo = null
    card.battlecry = null
    card.deathrottle = null
    card.sabotage = null

func Fireball(card):
    card.key = 'Fireball'
    card.card_name = 'Fireball'
    card.text = 'Deal 4 Damage to a familiar.'
    card.element = 'fire'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar'
    card.effect = 'deal_4'

func Pyrokinesis(card):
    card.key = 'Pyrokinesis'
    card.card_name = 'Pyrokinesis'
    card.text = 'Deal 5 Damage to all enemy familiars.'
    card.element = 'fire'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    card.effect = 'deal_5_all_enemy_familiars'

func IceWall(card):
    card.key = 'IceWall'
    card.card_name = 'Ice Wall'
    card.text = '' # #TODO: Can't attack.
    card.element = 'water'
    card.type = 'familiar'
    card.at = 0
    card.hp = 20

func GiantGrowth(card):
    card.key = 'GiantGrowth'
    card.card_name = 'Giant Growth'
    card.text = 'Give a Familiar +3/+3.'
    card.element = 'earth'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar'
    card.effect = 'plus_3_plus_3'

func Raid(card):
    card.key = 'Raid'
    card.card_name = 'Raid'
    card.text = 'Target Familiar gets +1/+1 and attacks.'
    card.element = 'earth'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar'
    card.effect = 'plus_1_plus_1_then_attack'

func GoblinLooter(card):
    card.key = 'GoblinLooter'
    card.card_name = 'Goblin Looter'
    card.text = 'First time this sabotages: Draw a card.'
    card.type = 'familiar'
    card.element = 'earth'
    card.at = 2
    card.hp = 2
    card.sabotage = 'sabotage__draw_a_card'
    
func IdolOfGrowth(card):
    card.key = 'IdolOfGrowth'
    card.card_name = 'Idol of Growth'
    card.text = 'Inspired Familiar gets +2/+2.'
    card.type = 'familiar'
    card.element = 'earth'
    card.at = 2
    card.hp = 2
    card.inspire = 'inspire__plus_2_plus_2'
    
func IdolOfSpeed(card):
    card.key = 'IdolOfSpeed'
    card.card_name = 'Idol of Speed'
    card.text = 'Inspired Familiar attacks immediately.'
    card.type = 'familiar'
    card.element = 'fire'
    card.at = 2
    card.hp = 2
    card.inspire = 'inspire__attack_immediately'
    
func IdolOfMirror(card):
    card.key = 'IdolOfMirror'
    card.card_name = 'Idol of Mirror'
    card.text = 'Add a copy of inspired card to your hand.'
    card.type = 'familiar'
    card.element = 'water'
    card.at = 2
    card.hp = 2
    card.inspire = 'inspire__copy_to_hand'
    
func IdolOfBlades(card):
    card.key = 'IdolOfBlades'
    card.card_name = 'Idol of Blades'
    card.text = 'Inspire: Add a Shiv to your hand.'
    card.type = 'familiar'
    card.element = 'earth'
    card.at = 2
    card.hp = 2
    card.inspire = 'inspire__create_a_shiv'
    
func IdolOfDragon(card):
    card.key = 'IdolOfDragon'
    card.card_name = 'Idol of Dragon'
    card.text = 'Inspired Familiar becomes a 5/5 Dragon.'
    card.type = 'familiar'
    card.element = 'fire'
    card.at = 2
    card.hp = 2
    card.inspire = 'inspire__become_a_dragon'
    
func TheShepherd(card):
    card.key = 'TheShepherd'
    card.card_name = 'The Shepherd'
    card.text = 'Battlecry: Fill your board with exploding 2/2 Sheeps.'
    card.type = 'familiar'
    card.element = 'water'
    card.at = 4
    card.hp = 5
    card.battlecry = 'battlecry__fill_board_with_sheeps'

func Sheep(card):
    card.key = 'Sheep'
    card.card_name = 'Sheep'
    card.text = 'Deathrottle: Deal 2 Damage to opposing side.'
    card.type = 'familiar'
    card.element = 'earth'
    card.at = 2
    card.hp = 2
    card.deathrottle = 'deathrottle__deal_2_in_lane'

func Phoenix(card):
    card.key = 'Phoenix'
    card.card_name = 'Phoenix'
    card.text = 'Deathrottle: Return to your hand as 6/6.'
    card.type = 'familiar'
    card.element = 'fire'
    card.at = 4
    card.hp = 4
    card.deathrottle = 'deathrottle__great_phoenix'

func GreatPhoenix(card):
    card.key = 'GreatPhoenix'
    card.card_name = 'Great Phoenix'
    card.text = 'Deathrottle: Return to your hand as 8/8.'
    card.type = 'familiar'
    card.element = 'fire'
    card.at = 6
    card.hp = 6
    card.deathrottle = 'deathrottle__blazing_phoenix'

func BlazingPhoenix(card):
    card.key = 'BlazingPhoenix'
    card.card_name = 'Blazing Phoenix'
    card.text = 'Battlecry: Deal 8 Damage to opposing side.'
    card.type = 'familiar'
    card.element = 'fire'
    card.at = 8
    card.hp = 8
    card.battlecry = 'battlecry__deal_8_in_lane'

func Scout(card):
    card.key = 'Scout'
    card.card_name = 'Scout'
    card.text = 'Draw a card for each enemy familiar.'
    card.element = 'water'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    card.effect = 'draw_one_for_each_enemy_familiar'

func Blacksmith(card):
    card.key = 'Blacksmith'
    card.card_name = 'Blacksmith'
    card.text = 'While approaching, Familiars you play gain +2/+2.'
    card.type = 'familiar'
    card.element = 'earth'
    card.at = 2
    card.hp = 4
    card.whenever = { play_card = 'own_familiar__plus_2_plus_2'}

func Cinderstorm(card):
    card.key = 'Cinderstorm'
    card.card_name = 'Cinderstorm'
    card.text = 'Deal 3 Damage. (6 if your approaching card if Fire.)'
    card.element = 'fire'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar_or_tower'
    card.effect = 'deal_3_if_approching_fire_deal_6'

func PillarOfFire(card):
    card.key = 'PillarOfFire'
    card.card_name = 'Pillar of Fire'
    card.text = 'Deal 4 Damage to everything in a lane.'
    card.element = 'fire'
    card.type = 'sorcery'
    card.targeting = 'targets_field'
    card.effect = 'deal_4_all_in_lane'

func CarnivorousOoze(card):
    card.key = 'CarnivorousOoze'
    card.card_name = 'Carnivorous Ooze'
    card.text = 'Click to gain +1/-1.'
    card.type = 'familiar'
    card.element = 'water'
    card.at = 0
    card.hp = 7
    card.ignition = 'ignition__plus_1_minus_1'

func Bomber(card):
    card.key = 'Bomber'
    card.card_name = 'Bomber'
    card.text = 'Click to deal 2 Damage to everything in its lane.'
    card.type = 'familiar'
    card.element = 'fire'
    card.at = 3
    card.hp = 5
    card.ignition = 'ignition__deal_2_all_in_lane'

func VolJin(card):
    card.key = 'VolJin'
    card.card_name = 'Vol\'Jin'
    card.text = 'Battlecry: Swap HP with opposing familiar.'
    card.type = 'familiar'
    card.element = 'water'
    card.at = 6
    card.hp = 2
    card.battlecry = 'battlecry__swap_hp_opposing_familiar'
    
func Retreat(card):
    card.key = 'Retreat'
    card.card_name = 'Retreat'
    card.text = 'Return target friendly familiar to your hand.'
    card.element = 'water'
    card.type = 'sorcery'
    card.targeting = 'targets_friendly_familiar'
    card.effect = 'sorcery__return_to_hand'

func LoneChampion(card):
    card.key = 'LoneChampion'
    card.card_name = 'Lone Champion'
    card.text = 'Battlecry: Return your other Familiars to your hand.'
    card.type = 'familiar'
    card.element = 'fire'
    card.at = 6
    card.hp = 6
    card.battlecry = 'battlecry__return_others_to_hand'
    
func RightShift(card):
    card.key = 'RightShift'
    card.card_name = 'Right Shift'
    card.text = 'Move a familiar to the one lane to the right.'
    card.element = 'water'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar_with_empty_field_to_the_right'
    card.effect = 'sorcery__shift_to_right'

func Golem(card):
    card.key = 'Golem'
    card.card_name = 'Golem'
    card.text = 'Battlecry: Deal 2 Damage to all Familiars in other lanes.'
    card.type = 'familiar'
    card.element = 'earth'
    card.at = 2
    card.hp = 5
    card.battlecry = 'battlecry__deal_2_familiars_in_other_lanes'

func DragonHatchling(card):
    card.key = 'DragonHatchling'
    card.card_name = 'Dragon Hatchling'
    card.text = 'In 8 seconds: Becomes a 5/5 Dragon.'
    card.type = 'familiar'
    card.element = 'fire'
    card.at = 2
    card.hp = 3
    card.battlecry = 'battlecry__delay_8_become_a_dragon'

func Cleric(card):
    card.key = 'Cleric'
    card.card_name = 'Cleric'
    card.text = 'Every 2 seconds: Allies in other lanes get +0/+2.'
    card.type = 'familiar'
    card.element = 'water'
    card.at = 1
    card.hp = 4
    card.battlecry = 'battlecry__every_2_allies_other_lanes_plus_0_plus_2'

func Disarm(card):
    card.key = 'Disarm'
    card.card_name = 'Disarm'
    card.text = 'Target Familiar gets -4/-2.'
    card.element = 'water'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar'
    card.effect = 'sorcery__minus_4_minus_2'

func Languish(card):
    card.key = 'Languish'
    card.card_name = 'Languish'
    card.text = 'All Familiars get -4/-4. In 5 seconds: They get +4/+4.'
    card.element = 'water'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    card.effect = 'sorcery__all_minus_4_minus_4_delay_plus_4_plus_4'

func PowerOverwhelming(card):
    card.key = 'PowerOverwhelming'
    card.card_name = 'Power Overwhelming'
    card.text = 'Target Familiar gets +5/+5. In 8 seconds: It dies.'
    card.element = 'fire'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar'
    card.effect = 'sorcery__plus_5_plus_5_delay_selfdestruct'

func FateWeaver(card):
    card.key = 'FateWeaver'
    card.card_name = 'Fate Weaver'
    card.text = 'Every 4 seconds: Draw a card, discard your leftmost.'
    card.type = 'familiar'
    card.element = 'water'
    card.at = 2
    card.hp = 5
    card.battlecry = 'battlecry__every_4_draw_1_discard_leftmost'

func CreativeBurst(card):
    card.key = 'CreativeBurst'
    card.card_name = 'Creative Burst'
    card.text = 'Draw 3 cards. In 8 seconds: Discard them.'
    card.element = 'fire'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    card.effect = 'sorcery__draw_3_delay_discard'
    
func CrystalForge(card):
    card.key = 'CrystalForge'
    card.card_name = 'Crystal Forge'
    card.text = 'Every 4 seconds: Create a Shiv.'
    card.type = 'familiar'
    card.element = 'earth'
    card.at = 0
    card.hp = 6
    card.battlecry = 'battlecry__every_4_create_a_shiv'

func DoubleShot(card):
    card.key = 'DoubleShot'
    card.card_name = 'Double Shot'
    card.text = 'Deal 3 Damage to a Familiar, now and in 3 seconds.'
    card.element = 'fire'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar'
    card.effect = 'sorcery__deal_3_delay_deal_3'



# Enemy Cards
# ---------------------------------------------------------------------------------------------

func Goblin(card):
    card.key = 'Goblin'
    card.card_name = 'Goblin'
    card.text = ''
    card.type = 'familiar'
    card.element = 'earth'
    card.at = 4
    card.hp = 3
    
func Hobgoblin(card):
    card.key = 'Hobgoblin'
    card.card_name = 'Hobgoblin'
    card.text = ''
    card.type = 'familiar'
    card.element = 'earth'
    card.at = 6
    card.hp = 6

func Kirin(card):
    card.key = 'Kirin'
    card.card_name = 'Kirin'
    card.text = 'Battlecry: Deal 4 Damage to opposing side.'
    card.type = 'familiar'
    card.element = 'fire'
    card.at = 10
    card.hp = 10
    card.battlecry = 'battlecry__deal_4_in_lane'

func BatteringRam(card):
    card.key = 'BatteringRam'
    card.card_name = 'Battering Ram'
    card.text = 'Battlecry: Deal 4 Damage to opposing side.'
    card.type = 'familiar'
    card.element = 'earth'
    card.at = 2
    card.hp = 6
    card.battlecry = 'battlecry__deal_4_in_lane'

func SiegeTower(card):
    card.key = 'SiegeTower'
    card.card_name = 'Siege Tower'
    card.text = 'Deathrottle: Fill your board with Hobgoblins.'
    card.type = 'familiar'
    card.element = 'earth'
    card.at = 3
    card.hp = 8
    card.deathrottle = 'deathrottle__fill_board_with_hobgoblins'

func Halberd(card):
    card.key = 'Halberd'
    card.card_name = 'Halberd'
    card.text = 'Target Familiar gets +3/+3 and attacks.'
    card.element = 'earth'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar'
    card.effect = 'plus_3_plus_3_then_attack'

func RockThrow(card):
    card.key = 'RockThrow'
    card.card_name = 'Rock Throw'
    card.text = 'Deal 5 Damage to a familiar.'
    card.element = 'earth'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar'
    card.effect = 'deal_6'

func ManaSapling(card):
    card.key = 'ManaSapling'
    card.card_name = 'Mana Sapling'
    card.text = 'Whenever a card is played, gain +1/+1.'
    card.type = 'familiar'
    card.element = 'earth'
    card.at = 2
    card.hp = 5
    card.whenever = { play_card = 'on_field__plus_1_plus_1'}

func Juggernaut(card):
    card.key = 'Juggernaut'
    card.card_name = 'Juggernaut'
    card.text = 'Whenever this attacks, gain +3/+0.'
    card.type = 'familiar'
    card.element = 'earth'
    card.at = 1
    card.hp = 10
    card.whenever = { attack = 'this__plus_3_plus_0'}

func Counterspell(card): # Rename to Disarm?
    card.key = 'Counterspell'
    card.card_name = 'Counterspell'
    card.text = 'Opponent discards all Sorceries.'
    card.element = 'water'
    card.type = 'sorcery'
    card.targeting = 'targets_not_required'
    card.effect = 'opponent_discards_all_sorceries'

func BearTrap(card):
    card.key = 'BearTrap'
    card.card_name = 'Bear Trap'
    card.text = 'Deal 4 Damage. Approching: Cast on first played familiar played.'
    card.element = 'earth'
    card.type = 'sorcery'
    card.targeting = 'targets_familiar_or_tower'
    card.effect = 'deal_4'
    card.whenever = { play_card = 'approaching__cast_on_familiar'}

func RareHunter(card):
    card.key = 'RareHunter'
    card.card_name = 'Rare Hunter'
    card.text = 'Approching: Deal 2 Damage to played familiars.'
    card.element = 'earth'
    card.type = 'familiar'
    card.at = 2
    card.hp = 5
    card.whenever = { play_card = 'approaching__deal_2_to_familiar'}

func Saboteur(card):
    card.key = 'Saboteur'
    card.card_name = 'Saboteur'
    card.text = 'Battlecry: Opponent discards his/her leftmost card.'
    card.type = 'familiar'
    card.element = 'earth'
    card.at = 2
    card.hp = 6
    card.battlecry = 'battlecry__opponent_discard_leftmost'

# Extra Deck Cards
# ---------------------------------------------------------------------------------------------

func QuickForge(card):
    card.key = 'QuickForge'
    card.card_name = 'Quick Forge'
    card.text = 'Add 3 Shivs to your hand.'
    card.element = 'earth'
    card.type = 'sorcery'
    card.extra_effect = 'extra__create_3_shivs'
    card.element_sequence = ['earth', 'earth', 'earth']

func BraveCharge(card):
    card.key = 'BraveCharge'
    card.card_name = 'Brave Charge'
    card.text = 'Your familiars on the field and in hand gain +2/+2.'
    card.element = 'fire'
    card.type = 'sorcery'
    card.extra_effect = 'extra__plus_2_plus_2_hand_field'
    card.element_sequence = ['fire', 'fire', 'fire']

func Dethrone(card):
    card.key = 'Dethrone'
    card.card_name = 'Dethrone'
    card.text = 'Deal 3 Damage to the familiar(s) with highest HP.'
    card.element = 'fire'
    card.type = 'sorcery'
    card.extra_effect = 'extra__deal_3_to_highest_hp_familiar'
    card.element_sequence = ['fire']

func Duplicate(card):
    card.key = 'Duplicate'
    card.card_name = 'Duplicate'
    card.text = 'Copy the leftmost card in your hand.'
    card.element = 'water'
    card.type = 'sorcery'
    card.extra_effect = 'extra__copy_leftmost_card'
    card.element_sequence = ['water']

