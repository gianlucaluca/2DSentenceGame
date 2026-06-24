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
		ui.add_log("Defeat...")
		await get_tree().create_timer(4).timeout
		battle_end.emit(false)
		OverworldState._on_battle_finished(false)
		return

	start_player_turn()

func validate(spell: Array) -> bool:
	if (spell.size() < 4):
		return false
	return (
		WordDatabase.get_initiator(spell[0]) != null and
		WordDatabase.get_projectile(spell[1]) != null and
		WordDatabase.get_augment(spell[2]) != null and
		WordDatabase.get_targeting(spell[3]) != null
	)


func _on_sentence_submitted(submission):

	if state != State.PLAYER_INPUT:
		return

	state = State.RESOLVE

	if !validate(submission):
		ui.add_log("Incorrect spell. Turn lost.")
		end_player_turn()
		return

	resolver.resolve(submission, player, enemy)

	if enemy.health <= 0:
		enemy.visible = false
		ui.add_log("")
		ui.add_log("Victory!")
		var leveled_up: bool = PlayerStats.add_exp(enemy.givenXP)
		ui.add_log("Gained %d XP from the battle." % enemy.givenXP)
		
		if (leveled_up):
			ui.add_log("You leveled up!")
			ui.add_log("You are now level %d" % PlayerStats.get_level())
			ui.add_log("Your battle stats have slightly increased.")
			await get_tree().create_timer(5).timeout
		else:
			await get_tree().create_timer(2.5).timeout
		# doesn't immediately terminate. some leeway
		
		
		battle_end.emit(true)
		OverworldState._on_battle_finished(true)
		return

	end_player_turn()
