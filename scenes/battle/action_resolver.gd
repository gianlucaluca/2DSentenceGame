extends Node
class_name ActionResolver

@export var ui: BattleUI
@export var player_crit_sfx: AudioStreamPlayer
@export var player_hit_sfx: AudioStreamPlayer
@export var miss_sfx: AudioStreamPlayer
@export var heal: AudioStreamPlayer
var spell_log = {}

func resolve(spell: Array, attacker: BattlePlayer, target: BattleEnemy):

	var damage = attacker.baseDamage * WordDatabase.get_projectile(spell[1]).get_damage_modifier()

	if !(WordDatabase.get_augment(spell[2]).damage_type == "healing"):
		if WordDatabase.get_augment(spell[2]).damage_type in target.weaknesses:
			player_crit_sfx.play()
			damage *= WordDatabase.get_augment(spell[2]).get_weakness_multiplier()
			ui.add_log("The attack was super effective!")
		if WordDatabase.get_augment(spell[2]).damage_type in target.resistances:
			damage *= WordDatabase.get_augment(spell[2]).get_resistance_multiplier()
			ui.add_log("The attack was not very effective...")
	else:
		# negative damage to heal the player
		damage *= -1 * 2

	

	damage = int(damage)
	
	var resultingSpell: String = ""
	for i in 4:
		resultingSpell += spell[i] + " "
	
	#debug purposes
	#ui.add_log("You used: " + resultingSpell + "!")
	
	if (spell_log.has(resultingSpell)):
		var damage_penalty = spell_log.get(resultingSpell)
		damage *= .25 * damage_penalty
		spell_log.set(resultingSpell, damage_penalty + 1)
		ui.add_log("Spell has been used before. Isn't as effective...")
	else:
		spell_log.set(resultingSpell, 1)
	
	var accuracy = WordDatabase.get_projectile(spell[1]).accuracy
	# accuracy check
	var rng = randf()
	print(rng)
	if (WordDatabase.get_targeting(spell[3])).word == "sobre mi mismo":
		attacker.take_damage(damage)
	if (rng > accuracy):
		
		ui.add_log("Just missed!")
		miss_sfx.play()
	else:
		target.take_damage(damage)
		if (WordDatabase.get_augment(spell[2]).damage_type == "healing"):
			heal.play()
			var healed = damage * -1
			ui.add_log("You healed yourself for %d HP." % healed)
		else:
			ui.add_log("Enemy takes %d damage." % damage)
			player_hit_sfx.play()



	
