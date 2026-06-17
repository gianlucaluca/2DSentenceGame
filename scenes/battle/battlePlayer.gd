extends Node2D
class_name BattlePlayer

@export var max_HP: int
@export var max_Mana: int 
@export var baseDamage: int


var health: int
var mana_points: int

signal manaChanged(amount: int)

func _ready() -> void:
	var health = max_HP
	var mana_points = max_Mana

func take_damage(damage: int) -> void:
	if (damage < 1):
		return
	health -= damage
	
#probably unused
func heal(healing: int) -> void:
	if (healing < 0):
		return
	health += healing
	
func useGrimoire() -> void:
	mana_points -= 1
	manaChanged.emit(1)
