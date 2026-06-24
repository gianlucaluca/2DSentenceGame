extends Node2D
class_name BattleEnemy

# ideas for enemies
# rock would have lots of hp, weak to wind
# fire would be weak to ice
# ice weak to fire
# wind is weak to electric
# electric is weak to wind

@export var enemy_types: Node

var max_HP: int
var baseDamage: int
var givenXP: int
var weaknesses: Array[String]
var resistances: Array[String]
var health: int

@export var health_bar: ProgressBar
@export var enemy_sprite: Sprite2D

func _ready() -> void:
	
	var possible_enemies:= enemy_types.get_children()
	
	var selected_enemy = possible_enemies[randi_range(0, possible_enemies.size() - 1)]
	
	max_HP = selected_enemy.get_hp()
	baseDamage = selected_enemy.get_damage()
	givenXP = selected_enemy.get_xp()
	weaknesses = selected_enemy.get_weaknesses()
	resistances = selected_enemy.get_resistances()
	
	# default texture will be used otherwise if we forget one
	if (selected_enemy.get_image() != null):
		enemy_sprite.texture = selected_enemy.get_image()
	
	health = max_HP
	health_bar.max_value = max_HP
	health_bar.value = health

func take_damage(damage: int) -> void:
	if (damage < 1):
		return
	health -= damage
	health_bar.value = health
	if (health <= 0):
		enemy_sprite.queue_free()
	
func heal(healing: int) -> void:
	if (healing < 0):
		return
	health += healing
	health_bar.value = health
