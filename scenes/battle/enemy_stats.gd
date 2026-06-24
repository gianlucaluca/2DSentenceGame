extends Node

class_name BattleEnemyStats

@export var max_HP: int
@export var baseDamage: int
@export var givenXP: int
# refer to scenes/battle/words/augments for element names
@export var weaknesses: Array[String]
@export var resistances: Array[String]
@export var skin: CompressedTexture2D

func get_hp() -> int:
	return max_HP
func get_damage() -> int:
	return baseDamage
func get_xp() -> int:
	return givenXP
func get_weaknesses() -> Array[String]:
	return weaknesses
func get_resistances() -> Array[String]:
	return resistances
func get_image() -> CompressedTexture2D:
	return skin
