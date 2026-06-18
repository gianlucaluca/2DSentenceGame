extends Resource
class_name AugmentData

@export var word: String
@export var damage_type: String
@export var weakness_multiplier: float
@export var resistance_multiplier: float

func get_word() -> String:
	return word

func get_damage_type() -> String:
	return damage_type

func get_weakness_multiplier() -> float:
	return weakness_multiplier

func get_resistance_multiplier() -> float:
	return resistance_multiplier
