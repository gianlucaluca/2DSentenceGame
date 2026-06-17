extends Control


func _on_grimoire_button_pressed() -> void:
	if (self.visible == false):
		self.visible = true
	else:
		self.visible = false
