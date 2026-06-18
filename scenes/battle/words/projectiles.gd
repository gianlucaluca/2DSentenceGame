extends Resource
class_name ProjectileData

@export var word: String
@export var damage_modifier: float
@export var accuracy: float

func get_word() -> String:
	return word

func get_damage_modifier() -> float:
	return damage_modifier

func get_accuracy() -> float:
	return accuracy
