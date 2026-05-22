class_name DayReport
extends Control

static var pending_summary: Dictionary = {}

var _is_terminal: bool = false
var _selected_consequence: Dictionary = {}
var _selected_terminal: Dictionary = {}
var _debug_panel: PanelContainer
var _debug_label: Label

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
	_build_debug_panel()
	_populate(pending_summary)
	var current_day: int = pending_summary.get("day", 1)
	header_label.text = "REPORTE DEL TURNO — DIA %d" % current_day
	restart_btn.pressed.connect(_on_restart_pressed)
	if not _is_terminal:
		_maybe_add_continue_button(current_day)
	_update_debug_panel()

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and event.keycode == KEY_Y:
		if _debug_panel != null:
			_debug_panel.visible = not _debug_panel.visible

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
	_selected_consequence = NarrativeConsequenceSystem.evaluate(summary, day)
	_selected_terminal = TerminalEndingSystem.evaluate(summary)
	if not _selected_terminal.is_empty():
		_is_terminal = true
		_show_terminal_ending(_selected_terminal)
	else:
		consequence_title_label.text = str(_selected_consequence.get("title", "CONSECUENCIA"))
		consequence_text.text = str(_selected_consequence.get("body", ""))
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

func _build_debug_panel() -> void:
	_debug_panel = PanelContainer.new()
	_debug_panel.visible = false
	_debug_panel.z_index = 100
	_debug_panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_debug_panel.set_anchors_preset(Control.PRESET_RIGHT_WIDE)
	_debug_panel.custom_minimum_size = Vector2(420, 0)
	_debug_panel.offset_left = -420

	var style := StyleBoxFlat.new()
	style.bg_color = Color(0.03, 0.03, 0.06, 0.93)
	style.border_color = Color(0.55, 0.90, 1.0, 1)
	style.set_border_width_all(1)
	style.set_content_margin_all(8)
	_debug_panel.add_theme_stylebox_override("panel", style)

	var vbox := VBoxContainer.new()
	vbox.mouse_filter = Control.MOUSE_FILTER_IGNORE

	var title := Label.new()
	title.text = "[ DEBUG — REPORTE ]"
	title.add_theme_color_override("font_color", Color(0.55, 0.90, 1.0, 1))
	title.add_theme_font_size_override("font_size", 11)
	title.mouse_filter = Control.MOUSE_FILTER_IGNORE

	var sep := HSeparator.new()
	sep.mouse_filter = Control.MOUSE_FILTER_IGNORE

	var scroll := ScrollContainer.new()
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	scroll.mouse_filter = Control.MOUSE_FILTER_IGNORE

	_debug_label = Label.new()
	_debug_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_debug_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_debug_label.add_theme_font_size_override("font_size", 11)
	_debug_label.add_theme_color_override("font_color", Color(0.55, 0.90, 1.0, 1))
	_debug_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_debug_label.text = "Sin datos."

	scroll.add_child(_debug_label)
	vbox.add_child(title)
	vbox.add_child(sep)
	vbox.add_child(scroll)
	_debug_panel.add_child(vbox)
	add_child(_debug_panel)

func _update_debug_panel() -> void:
	if _debug_label == null:
		return
	var s := pending_summary
	if s.is_empty():
		_debug_label.text = "Sin datos de turno."
		return

	var day: int = s.get("day", 1)
	var lines: Array = []
	lines.append("DIA:        %d" % day)
	lines.append("PROCESADOS: %d / %d" % [s.get("total", 0), s.get("quota", s.get("total", 0))])
	lines.append("CORRECTAS:  %d" % s.get("correct", 0))
	lines.append("ERRORES:    %d" % s.get("errors", 0))
	lines.append("CREDITOS:   %d" % s.get("credits", 0))
	lines.append("")

	lines.append("--- DECISIONES ---")
	var decisions: Array = s.get("decisions", [])
	if decisions.is_empty():
		lines.append("  (ninguna)")
	else:
		for d in decisions:
			var ok: String = "[OK]" if d.get("was_correct", false) else "[! ]"
			lines.append("%s %s — %s" % [ok, d.get("applicant_name", "?"), d.get("decision", "?").to_upper()])
			lines.append("     id:      %s" % d.get("applicant_id", "No disponible"))
			lines.append("     espera:  %s" % d.get("correct_decision", "No disponible").to_upper())
			lines.append("     riesgo:  %s" % d.get("risk_level", "No disponible").to_upper())
			var delta: int = d.get("credit_delta", 0)
			if delta != 0:
				lines.append("     creditos: %d" % delta)
			var viols: Array = d.get("violations", [])
			if not viols.is_empty():
				lines.append("     viols:   %s" % ", ".join(viols))
	lines.append("")

	lines.append("--- FLAGS NARRATIVOS ---")
	var flags: Array = s.get("activated_flags", [])
	if flags.is_empty():
		lines.append("  (ninguno)")
	else:
		for f in flags:
			lines.append("  • %s" % str(f))
	lines.append("")

	lines.append("--- ACUMULADORES ---")
	var acc := NarrativeStateSystem.get_accumulators()
	for k in acc:
		lines.append("  %s: %d" % [k, acc[k]])
	lines.append("")

	lines.append("--- CONSECUENCIA SELECCIONADA ---")
	var c := _selected_consequence
	if c.is_empty():
		lines.append("  Neutral (sin datos o sin coincidencia)")
	else:
		lines.append("  id:       %s" % c.get("id", "No disponible"))
		lines.append("  type:     %s" % c.get("type", "No disponible"))
		lines.append("  priority: %d" % c.get("priority", 0))
		if c.has("trigger_flag"):
			lines.append("  flag:     %s" % str(c["trigger_flag"]))
		lines.append("  title:    %s" % c.get("title", "No disponible"))
	lines.append("  archivo:  res://data/consequences/consequences_day_%02d.json" % day)
	lines.append("")

	if not _selected_terminal.is_empty():
		lines.append("--- CIERRE TERMINAL ---")
		lines.append("  id:       %s" % _selected_terminal.get("id", "No disponible"))
		lines.append("  priority: %d" % _selected_terminal.get("priority", 0))
		lines.append("  title:    %s" % _selected_terminal.get("title", "No disponible"))
	else:
		lines.append("--- CIERRE TERMINAL ---")
		lines.append("  (no activado)")

	_debug_label.text = "\n".join(lines)

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
