extends Node
class_name BattleController

@export var ui: BattleUI

@export var player: BattlePlayer

@export var enemy: BattleEnemy

@export var resolver: ActionResolver

signal battle_end(win: bool)

enum State {
	PLAYER_INPUT,
	ENEMY_TURN,
	RESOLVE,
	END
}

var state := State.PLAYER_INPUT

func _ready() -> void:
	start_player_turn()
	
func start_player_turn():

	state = State.PLAYER_INPUT
	ui.set_input_enabled(true)
	
func end_player_turn():

	state = State.ENEMY_TURN
	ui.set_input_enabled(false)

	await get_tree().create_timer(1.0).timeout

	enemy_turn()

func enemy_turn():

	player.take_damage(enemy.baseDamage)

	ui.add_log("Enemy attacks for %d damage." % enemy.baseDamage)

	if player.health <= 0:
		ui.add_log("Defeat!")
		battle_end.emit(false)

	start_player_turn()

func validate(spell: Array) -> bool:
	if (spell.size() < 4):
		return false
	return (
		WordDatabase.get_initiator(spell[0]) != null and
		WordDatabase.get_augment(spell[1]) != null and
		WordDatabase.get_projectile(spell[2]) != null and
		WordDatabase.get_targeting(spell[3]) != null
	)


func _on_sentence_submitted(submission):

	if state != State.PLAYER_INPUT:
		return

	state = State.RESOLVE

	if !validate(submission):
		ui.add_log("Invalid spell. Turn lost.")
		end_player_turn()
		return

	resolver.resolve(submission, player, enemy)

	if enemy.health <= 0:
		ui.add_log("Victory!")
		battle_end.emit(true)
		OverworldState._on_battle_finished(true)
		return

	end_player_turn()
