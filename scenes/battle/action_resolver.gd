extends Node
class_name ActionResolver

@export var ui: BattleUI

func resolve(spell: Array[String], attacker: BattlePlayer, target: BattleEnemy):

	var damage = attacker.baseDamage * WordDatabase.get_projectile(spell[2]).damage_modifer

	if WordDatabase.get_augment(spell[1]).damage_type in target.weaknesses:
		damage *= WordDatabase.get_augment(spell[1]).weakness_multiplier

	if WordDatabase.get_augment(spell[1]).damage_type in target.resistances:
		damage *= WordDatabase.get_augment(spell[1]).resistance_multiplier

	damage = int(damage)

	target.take_damage(damage)

	var resultingSpell: String = ""
	for i in 3:
		resultingSpell += spell[i] + " "
	
	ui.add_log(
		"You used: " + resultingSpell + "!"
	)

	ui.add_log("Enemy takes %d damage." % damage)
