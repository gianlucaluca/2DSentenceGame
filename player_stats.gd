extends Node

# For now, hp starts the same every battle.
# In the final build, mana will reset per battle for sure.

# @export DOES NOT WORK
# have to edit here.
var battle_start_hp: int = 100
var battle_start_damage: int = 10
var player_level: int = 1
var player_xp: int = 0
var player_mana = 20


# Global functions to increase / decrease the player's stats. 
# Use with a call to the global node that is available at all times.
# Only affects battle screens. 
func inc_hp(new_HP: int) -> void:
	battle_start_hp = new_HP 
	
func inc_damage(new_damage: int) -> void:
	battle_start_damage = new_damage

# Global getters
func get_hp() -> int: 
	return battle_start_hp
	
func get_damage() -> int:
	return battle_start_damage

func get_mana() -> int:
	return player_mana
func lower_mana() -> void:
	player_mana -= 1

func get_level() -> int:
	return player_level

func level_up() -> void:
	player_level += 1
	inc_hp(10)
	inc_damage(1)
	player_mana -= 1
	
# XP isn't visible, but the system exists
func add_exp(xp: int) -> bool:
	player_xp += xp
	
	# this code sucks im sorry
	
	if (player_xp > 100 && player_level < 2):
		level_up()
		return true
		
	if (player_xp > 200 && player_level < 3):
		level_up()
		return true

	if (player_xp > 100 && player_level < 4):
		level_up()
		return true

	return false
