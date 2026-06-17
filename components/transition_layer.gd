extends CanvasLayer

var rect: ColorRect

const FADE_DURATION := 0.4

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	layer = 128
	rect = ColorRect.new()
	rect.color = Color.BLACK
	rect.color.a = 0.0
	rect.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	add_child(rect)


func fade_out() -> void:
	var tween := create_tween()
	tween.tween_property(rect, "color:a", 1.0, FADE_DURATION)
	await tween.finished


func fade_in() -> void:
	var tween := create_tween()
	tween.tween_property(rect, "color:a", 0.0, FADE_DURATION)
	await tween.finished
