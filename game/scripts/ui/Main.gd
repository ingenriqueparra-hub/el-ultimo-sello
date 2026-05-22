extends Control

const COLOR_BG := Color(0.04, 0.06, 0.04, 1)
const COLOR_TEXT := Color(0.18, 0.82, 0.18, 1)
const COLOR_TEXT_DIM := Color(0.35, 0.55, 0.35, 1)
const COLOR_BTN := Color(0.08, 0.36, 0.08, 1)

@onready var start_btn: Button = $CenterContainer/VBox/StartButton

func _ready() -> void:
	_apply_theme()
	start_btn.pressed.connect(_on_start_pressed)

func _apply_theme() -> void:
	var style := StyleBoxFlat.new()
	style.bg_color = COLOR_BTN
	style.border_color = COLOR_TEXT
	style.set_border_width_all(1)
	style.set_content_margin_all(10)

	var style_hover := StyleBoxFlat.new()
	style_hover.bg_color = COLOR_BTN.lightened(0.25)
	style_hover.border_color = COLOR_TEXT
	style_hover.set_border_width_all(1)
	style_hover.set_content_margin_all(10)

	start_btn.add_theme_stylebox_override("normal", style)
	start_btn.add_theme_stylebox_override("hover", style_hover)
	start_btn.add_theme_color_override("font_color", COLOR_TEXT)

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main/ControlDesk.tscn")
