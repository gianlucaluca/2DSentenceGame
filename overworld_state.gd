extends Node

var overworld
var battle_scene: PackedScene = preload("res://scenes/battle/battle.tscn")
var current_battle = null

func start_battle():
	# temporary fix, this is unsafe and bad. REMOVE THIS LATER
	# need this to be the otherway around, but whatever
	if overworld.get_name() == "Playground_01":
		return
	if current_battle != null:
		return

	
	current_battle = battle_scene.instantiate()
	#var player_entity = overworld.get_node("Entities/Player")

	#current_battle.battle_finished.connect(_on_battle_finished)

	print(overworld)
	print(current_battle)
	overworld.process_mode = Node.PROCESS_MODE_DISABLED
	overworld.add_child(current_battle)

	get_tree().paused = true

	current_battle.process_mode = Node.PROCESS_MODE_WHEN_PAUSED

func _on_battle_finished(victory: bool):

	get_tree().paused = false

	#if victory and current_battle.enemy:
	#	current_battle.enemy.queue_free()

	current_battle.queue_free()
	current_battle = null
	
	overworld.process_mode = Node.PROCESS_MODE_ALWAYS
	
	if (!victory):
		get_tree().reload_current_scene()

func set_overworld(newScene: Node2D):
	overworld = newScene
	print(overworld)
