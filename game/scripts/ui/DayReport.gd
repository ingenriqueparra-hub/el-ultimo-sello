class_name DayReport
extends Control

static var pending_summary: Dictionary = {}

var _is_terminal: bool = false

const COLOR_PANEL  := Color(0.06, 0.10, 0.06, 1)
const COLOR_BORDER := Color(0.15, 0.45, 0.15, 1)
const COLOR_TEXT   := Color(0.18, 0.82, 0.18, 1)
const COLOR_OK     := Color(0.18, 0.82, 0.18, 1)
const COLOR_ERROR  := Color(0.82, 0.22, 0.22, 1)
const COLOR_DIM    := Color(0.35, 0.55, 0.35, 1)
const COLOR_BTN    := Color(0.08, 0.36, 0.08, 1)

@onready var header_label: Label      = $VBox/Header/HeaderLabel
@onready var processed_label: Label   = $VBox/ScrollArea/ContentVBox/SummaryPanel/SummaryVBox/ProcessedLabel
@onready var correct_label: Label     = $VBox/ScrollArea/ContentVBox/SummaryPanel/SummaryVBox/CorrectLabel
@onready var errors_label: Label      = $VBox/ScrollArea/ContentVBox/SummaryPanel/SummaryVBox/ErrorsLabel
@onready var credits_label: Label     = $VBox/ScrollArea/ContentVBox/SummaryPanel/SummaryVBox/CreditsLabel
@onready var decisions_list: VBoxContainer = $VBox/ScrollArea/ContentVBox/DecisionsPanel/DecisionsVBox/DecisionsList
@onready var consequence_title_label: Label = $VBox/ScrollArea/ContentVBox/ConsequencePanel/ConsequenceVBox/ConsequenceTitle
@onready var consequence_text: Label  = $VBox/ScrollArea/ContentVBox/ConsequencePanel/ConsequenceVBox/ConsequenceText
@onready var restart_btn: Button      = $VBox/Footer/FooterHBox/RestartBtn

func _ready() -> void:
	_apply_theme()
	_populate(pending_summary)
	var current_day: int = pending_summary.get("day", 1)
	header_label.text = "REPORTE DEL TURNO — DIA %d" % current_day
	restart_btn.pressed.connect(_on_restart_pressed)
	if not _is_terminal:
		_maybe_add_continue_button(current_day)

func _populate(summary: Dictionary) -> void:
	if summary.is_empty():
		consequence_text.text = "Sin datos de turno."
		return

	var total: int   = summary.get("total", 0)
	var correct: int = summary.get("correct", 0)
	var errors: int  = summary.get("errors", 0)
	var credits: int = summary.get("credits", 50)

	var quota: int = summary.get("quota", total)
	processed_label.text = "Procesados:           %d / %d" % [total, quota]
	correct_label.text   = "Decisiones correctas: %d" % correct
	errors_label.text    = "Errores:              %d" % errors
	credits_label.text   = "Creditos finales:     %d" % credits

	if errors > 0:
		errors_label.add_theme_color_override("font_color", COLOR_ERROR)
	if credits < 30:
		credits_label.add_theme_color_override("font_color", COLOR_ERROR)

	for decision in summary.get("decisions", []):
		_add_decision_row(decision)

	var day: int = summary.get("day", 1)
	var consequence := NarrativeConsequenceSystem.evaluate(summary, day)
	var terminal := TerminalEndingSystem.evaluate(summary)
	if not terminal.is_empty():
		_is_terminal = true
		_show_terminal_ending(terminal)
	else:
		consequence_title_label.text = str(consequence.get("title", "CONSECUENCIA"))
		consequence_text.text = str(consequence.get("body", ""))
		var symptom := NarrativeStateSystem.get_narrative_symptom()
		if symptom != "":
			consequence_text.text += "\n\n" + symptom

func _add_decision_row(decision: Dictionary) -> void:
	var was_correct: bool = decision.get("was_correct", false)
	var name: String      = decision.get("applicant_name", "?")
	var dec: String       = decision.get("decision", "?").to_upper()
	var delta: int        = decision.get("credit_delta", 0)

	var indicator := "[OK]" if was_correct else "[!] "
	var delta_str := ("  %d" % delta) if delta < 0 else ""
	var correct_str := ""
	if not was_correct:
		var correct_dec: String = decision.get("correct_decision", "?").to_upper()
		correct_str = "  →  %s" % correct_dec

	var row := Label.new()
	row.text = "%s  %-22s %s%s%s" % [indicator, name, dec, correct_str, delta_str]
	row.add_theme_color_override("font_color", COLOR_OK if was_correct else COLOR_ERROR)
	row.add_theme_font_size_override("font_size", 13)
	decisions_list.add_child(row)

func _apply_theme() -> void:
	_style_panel($VBox/Header, COLOR_PANEL, COLOR_BORDER)
	_style_panel($VBox/ScrollArea/ContentVBox/SummaryPanel, COLOR_PANEL, COLOR_BORDER)
	_style_panel($VBox/ScrollArea/ContentVBox/DecisionsPanel, COLOR_PANEL, COLOR_BORDER)
	_style_panel($VBox/ScrollArea/ContentVBox/ConsequencePanel, COLOR_PANEL, COLOR_BORDER)
	_style_panel($VBox/Footer, COLOR_PANEL, COLOR_BORDER)
	_apply_labels_color(self)

	var s_btn := StyleBoxFlat.new()
	s_btn.bg_color = COLOR_BTN
	s_btn.border_color = COLOR_TEXT
	s_btn.set_border_width_all(1)
	s_btn.set_content_margin_all(8)
	var s_hover := StyleBoxFlat.new()
	s_hover.bg_color = COLOR_BTN.lightened(0.2)
	s_hover.border_color = COLOR_TEXT
	s_hover.set_border_width_all(1)
	s_hover.set_content_margin_all(8)
	restart_btn.add_theme_stylebox_override("normal", s_btn)
	restart_btn.add_theme_stylebox_override("hover", s_hover)
	restart_btn.add_theme_color_override("font_color", COLOR_TEXT)

func _style_panel(panel: PanelContainer, bg: Color, border: Color) -> void:
	var style := StyleBoxFlat.new()
	style.bg_color = bg
	style.border_color = border
	style.set_border_width_all(1)
	style.set_content_margin_all(10)
	panel.add_theme_stylebox_override("panel", style)

func _apply_labels_color(node: Node) -> void:
	for child in node.get_children():
		if child is Label:
			child.add_theme_color_override("font_color", COLOR_TEXT)
		_apply_labels_color(child)

func _maybe_add_continue_button(current_day: int) -> void:
	var next_day := current_day + 1
	if not FileAccess.file_exists("res://data/days/day_%02d.json" % next_day):
		return
	var btn := Button.new()
	btn.text = "CONTINUAR — DIA %d" % next_day
	btn.custom_minimum_size = Vector2(280, 50)
	btn.add_theme_font_size_override("font_size", 18)
	var s := StyleBoxFlat.new()
	s.bg_color = Color(0.04, 0.16, 0.36, 1)
	s.border_color = COLOR_TEXT
	s.set_border_width_all(1)
	s.set_content_margin_all(8)
	var s_hover := StyleBoxFlat.new()
	s_hover.bg_color = Color(0.06, 0.24, 0.52, 1)
	s_hover.border_color = COLOR_TEXT
	s_hover.set_border_width_all(1)
	s_hover.set_content_margin_all(8)
	btn.add_theme_stylebox_override("normal", s)
	btn.add_theme_stylebox_override("hover", s_hover)
	btn.add_theme_color_override("font_color", COLOR_TEXT)
	btn.pressed.connect(func(): _on_continue_pressed(next_day))
	$VBox/Footer/FooterHBox.add_child(btn)

func _on_continue_pressed(next_day: int) -> void:
	pending_summary = {}
	ControlDesk.day_to_load = next_day
	get_tree().change_scene_to_file("res://scenes/main/ControlDesk.tscn")

func _show_terminal_ending(terminal: Dictionary) -> void:
	var color_terminal := Color(0.82, 0.18, 0.18, 1)
	consequence_title_label.text = str(terminal.get("title", "CIERRE TERMINAL"))
	consequence_title_label.add_theme_color_override("font_color", color_terminal)
	consequence_text.text = str(terminal.get("body", ""))
	consequence_text.add_theme_color_override("font_color", COLOR_TEXT)
	var panel := $VBox/ScrollArea/ContentVBox/ConsequencePanel
	var style := StyleBoxFlat.new()
	style.bg_color = Color(0.12, 0.04, 0.04, 1)
	style.border_color = color_terminal
	style.set_border_width_all(2)
	style.set_content_margin_all(10)
	panel.add_theme_stylebox_override("panel", style)
	restart_btn.text = "NUEVA PARTIDA"

func _on_restart_pressed() -> void:
	var day: int = pending_summary.get("day", 1)
	pending_summary = {}
	if _is_terminal:
		NarrativeStateSystem.reset()
		ControlDesk.day_to_load = 1
	else:
		NarrativeStateSystem.restore_snapshot()
		ControlDesk.day_to_load = day
	get_tree().change_scene_to_file("res://scenes/main/ControlDesk.tscn")
