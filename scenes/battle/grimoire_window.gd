extends Control

@export var player: BattlePlayer

func _on_grimoire_button_pressed() -> void:
	if ((self.visible == false) && (player.mana_points > 0)):
		self.visible = true
		#open_grimoire()
	else:
		self.visible = false
		# this is so poorly managed but it prevents losing a point for now
		#close_grimoire()

# UNUSED, i cant fix it idk
func open_grimoire():
	show()
	refresh()

func close_grimoire():
	hide()
	#clear()

func add_section(title, dict):

	var header = Label.new()
	header.text = "== " + title + " =="
	#list_container.add_child(header)

	for word in dict.values():
		var label = Label.new()
		label.text = word.word
		#list_container.add_child(label)

func refresh():

	#clear()

	# Show AUGMENTS (you can duplicate for other categories)
	add_section("Initiators", WordDatabase.initators)
	add_section("Augments", WordDatabase.augments)
	add_section("Projectiles", WordDatabase.projectiles)
	add_section("Targeting", WordDatabase.targetings)

#func clear():
	#for child in list_container.get_children():
		#child.queue_free()
