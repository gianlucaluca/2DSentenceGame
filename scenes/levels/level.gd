@tool
extends Node2D
class_name Level

@export_tool_button("Clear Tilemap Layers", "Callable") var clear_action = clear_tilemap_layers

@onready var tilemap_layers: Node2D = %Layers

var destination_name: String ## Used when moving between levels to get the right destination position for the player in the loaded level.
var player_id: int ## Used when moving between levels to save the player facing direction.

const BattleScene = preload("res://scenes/battle/battle.tscn")

var _battle_instance: Combat = null
var _current_enemy: Node = null
var _battle_ending := false

func init_scene():
	DataManager.load_level_data()

##internal - Used by SceneManager to pass data between levels.
func get_data():
	var data = {}
	if destination_name:
		data.destination_name = destination_name
	if player_id:
		data.player_id = player_id
	return data

##internal - Used by SceneManager to get data from the outgoing level.
func receive_data(data):
	if data.destination_name:
		destination_name = data.destination_name
	if data.player_id:
		player_id = data.player_id

func clear_tilemap_layers():
	for node in tilemap_layers.get_children():
		if node is TileMapLayer:
			node.clear()
			



func _ready() -> void:
	print("overworld ready called")
	#_player_instance = $Player25D/PlayerMath25D  # fix later
	
	for enemy in $Enemies.get_children():
		var enemy_data := enemy.get_node("EnemyData")
		if not enemy_data.contact_made.is_connected(_on_enemy_contacted):
			enemy_data.contact_made.connect(_on_enemy_contacted)


func _on_enemy_contacted(enemy: Node) -> void:
	if _battle_ending:
		return
	#_player_data = $Player25D/PlayerData # fix later
	_current_enemy = enemy
	#_player_instance.set_process_unhandled_input(false) # unnecessary
	get_tree().paused = true  # pause everything
	await TransitionLayer.fade_out()
	_battle_instance = BattleScene.instantiate()
	add_child(_battle_instance)
	_battle_instance.finished.connect(_on_battle_finished)
	_battle_instance.begin(enemy, _player_data)
	await TransitionLayer.fade_in()	

func _on_battle_finished(player_won: bool) -> void:
	if _battle_ending:
		return
	_battle_ending = true
	await TransitionLayer.fade_out()
	_battle_instance.finished.disconnect(_on_battle_finished)
	_player_data.curr_hp = _battle_instance.battle_manager.player_hp
	_battle_instance.free()
	_battle_instance = null
	if player_won:
		var defeated_enemy := _current_enemy.get_parent()
		_current_enemy = null
		defeated_enemy.visible = false
		defeated_enemy.get_parent().remove_child(defeated_enemy)
		defeated_enemy.free()
		print("won! nice work")
	else:
		print("yikers")
		_current_enemy = null
	get_tree().paused = false  # unpause
	await TransitionLayer.fade_in()
	
	
	_player_instance.set_process_unhandled_input(true)
	_battle_ending = false
	
	if not player_won:
		get_tree().reload_current_scene()


func _on_item_data_picked_up(item: ItemData) -> void:
	$Player25D/PlayerData.max_hp += item.amountHealed
	$Player25D/PlayerData.curr_hp = $Player25D/PlayerData.max_hp
	print("item collected")
