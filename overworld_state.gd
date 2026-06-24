extends Node

var overworld
var battle_scene: PackedScene = preload("res://scenes/battle/battle.tscn")
var start_level: String = "res://scenes/levels/tutorial.tscn"
var current_battle = null
var current_intro = null

func start_battle(initiator: Node):
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
	initiator.queue_free()

	get_tree().paused = true

	current_battle.process_mode = Node.PROCESS_MODE_WHEN_PAUSED

func tutorial_battle():
	current_battle = battle_scene.instantiate()
	overworld.add_child(current_battle)
	
func end_tutorial_battle():
	current_battle.queue_free()
	current_battle = null
	

func _on_battle_finished(victory: bool):

	if (victory):
		get_tree().paused = false

		#if victory and current_battle.enemy:
		#	current_battle.enemy.queue_free()

		current_battle.queue_free()
		current_battle = null

		overworld.process_mode = Node.PROCESS_MODE_ALWAYS
	
	if (!victory):
		#broken..?
		await get_tree().create_timer(1)
		get_tree().reload_current_scene()

func set_overworld(newScene: Node2D):
	overworld = newScene
	print(overworld)
