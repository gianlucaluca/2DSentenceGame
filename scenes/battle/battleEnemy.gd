extends Node2D
class_name BattleEnemy

@export var max_HP: int
@export var baseDamage: int
@export var weaknesses: Array[String]
@export var resistances: Array[String]

var health: int
@export var health_bar: ProgressBar

func _ready() -> void:
	health = max_HP
	health_bar.max_value = max_HP
	health_bar.value = health

func take_damage(damage: int) -> void:
	if (damage < 1):
		return
	health -= damage
	health_bar.value = health
	
func heal(healing: int) -> void:
	if (healing < 0):
		return
	health += healing
	health_bar.value = health
