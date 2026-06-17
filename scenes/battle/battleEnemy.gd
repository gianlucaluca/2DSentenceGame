extends Node2D
class_name BattleEnemy

@export var max_HP: int
@export var baseDamage: int
@export var weaknesses: Array[String]
@export var resistances: Array[String]

var health: int

func _ready() -> void:
	health = max_HP

func takeDamage(damage: int) -> void:
	if (damage < 1):
		return
	health -= damage
	
func heal(healing: int) -> void:
	if (healing < 0):
		return
	health += healing
