extends Node2D
class_name BattlePlayer

# THESE CURRENTLY DO NOTHING (EXCEPT MANA)
# Edit player_stats.gd in order to modify
@export var max_HP: int
@export var max_Mana: int 
@export var baseDamage: int

#this is temporary
@export var grimoire: Control


var health: int
@export var health_bar: ProgressBar
var mana_points: int
@export var mana_bar: ProgressBar

signal manaChanged(amount: int)

func _ready() -> void:
	# From Globals
	max_HP = PlayerStats.get_hp()
	baseDamage = PlayerStats.get_damage()
	
	health = max_HP
	mana_points = max_Mana
	health_bar.max_value = max_HP
	health_bar.value = health
	mana_bar.max_value = max_Mana
	mana_bar.value = mana_points

func take_damage(damage: int) -> void:
	if (damage < 1):
		return
	health -= damage
	health_bar.value = health
	
#probably unused
func heal(healing: int) -> void:
	if (healing < 0):
		return
	health += healing
	health_bar.value = health
	
func useGrimoire() -> void:
	if (grimoire.visible != false):
		mana_points -= 1
		mana_bar.value = mana_points
		manaChanged.emit(1)
	
