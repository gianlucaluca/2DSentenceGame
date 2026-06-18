class_name BattleUI
extends Control

signal spell_submit(spell: Array[String])

@export var initiator_box: LineEdit
@export var augment_box: LineEdit
@export var projectile_box: LineEdit
@export var targeting_box: LineEdit
@export var submit_button: Button
@export var log: RichTextLabel
	
func _on_submit():

# FOR FUTURE REFERENCE!!!!!
# index 0 is initiator
# index 1 is augment
# index 2 is projectile
# index 3 is targeting
# if size does not equal exactly 4, 
	var initiator = initiator_box.text
	var augment = augment_box.text
	var projectile = projectile_box.text
	var targeting = targeting_box.text
	
	var submission = [initiator, augment, projectile, targeting]


	spell_submit.emit(submission)

func add_log(text: String) -> void:
	log.append_text(text + "\n")

func set_input_enabled(enabled:bool):

	initiator_box.editable = enabled
	augment_box.editable = enabled
	projectile_box.editable = enabled
	targeting_box.editable = enabled
	submit_button.disabled = not enabled
