extends Node
class_name ActionResolver

@export var ui: BattleUI

func resolve(spell: Array, attacker: BattlePlayer, target: BattleEnemy):

	var damage = attacker.baseDamage * WordDatabase.get_projectile(spell[2]).get_damage_modifier()

	if !(WordDatabase.get_augment(spell[1]).damage_type == "healing"):
		if WordDatabase.get_augment(spell[1]).damage_type in target.weaknesses:
			damage *= WordDatabase.get_augment(spell[1]).get_weakness_multiplier()
			ui.add_log("The attack was super effective!")
		if WordDatabase.get_augment(spell[1]).damage_type in target.resistances:
			damage *= WordDatabase.get_augment(spell[1]).get_resistance_multiplier()
			ui.add_log("The attack was not very effective...")
	else:
		# negative damage to heal the player
		damage *= -1

	damage = int(damage)
	
	var resultingSpell: String = ""
	for i in 4:
		resultingSpell += spell[i] + " "
	
	ui.add_log(
		"You used: " + resultingSpell + "!"
	)
	
	var accuracy = WordDatabase.get_projectile(spell[2]).accuracy
	# accuracy check
	var rng = randf()
	print(rng)
	if (WordDatabase.get_targeting(spell[3])).word == "on myself":
		attacker.take_damage(damage)
	if (rng > accuracy):
		
		ui.add_log("Just missed!")
	else:
		target.take_damage(damage)
		if (WordDatabase.get_augment(spell[1]).damage_type == "healing"):
			var healed = damage * -1
			ui.add_log("You healed yourself for %d HP." % healed)
		else:
			ui.add_log("Enemy takes %d damage." % damage)



	
