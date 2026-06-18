extends Node

var initiators = {}
var augments = {}
var projectiles = {}
var targetings = {}

func _ready() -> void:
	load_words("res://scenes/battle/words/Initiators/", initiators)
	load_words("res://scenes/battle/words/Augments/", augments)
	load_words("res://scenes/battle/words/Projectiles/", projectiles)
	load_words("res://scenes/battle/words/Targeting/", targetings)
	print(initiators)
	print(augments)
	print(projectiles)
	print(targetings)

func load_words(path:String, dict:Dictionary):

	var dir = DirAccess.open(path)
	if dir == null:
		return

	for file in dir.get_files():

		if file.ends_with(".tres"):

			var resource = load(path + file)

			dict[resource.word] = resource
			
func get_initiator(input: String) -> InitiatorData:
	return initiators.get(input)
func get_augment(input: String) -> AugmentData:
	return augments.get(input)
func get_projectile(input: String) -> ProjectileData:
	return projectiles.get(input)
func get_targeting(input: String) -> TargetingData:
	return targetings.get(input)
