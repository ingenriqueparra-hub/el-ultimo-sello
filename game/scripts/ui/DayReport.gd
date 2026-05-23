class_name DayReport
extends Control

static var pending_summary: Dictionary = {}

var _is_terminal: bool = false
var _report: Dictionary = {}
var _selected_terminal: Dictionary = {}
var _debug_panel: PanelContainer
var _debug_label: Label

const _DECISION_LABELS := {"approve": "APROBADO", "reject": "RECHAZADO", "hold": "RETENIDO"}

const COLOR_PANEL  := Color(0.06, 0.10, 0.06, 1)
const COLOR_BORDER := Color(0.15, 0.45, 0.15, 1)
const COLOR_TEXT   := Color(0.18, 0.82, 0.18, 1)
const COLOR_OK     := Color(0.18, 0.82, 0.18, 1)
const COLOR_ERROR  := Color(0.82, 0.22, 0.22, 1)
const COLOR_DIM    := Color(0.35, 0.55, 0.35, 1)
const COLOR_BTN    := Color(0.08, 0.36, 0.08, 1)

const ASSET_TERMINAL_BG := "res://assets/ui/terminal/terminal_background.png"
const ASSET_SCANLINES := "res://assets/ui/overlays/scanline_overlay.png"
const ASSET_GRIME := "res://assets/ui/overlays/grime_overlay.png"
const ASSET_CRT_WEAR := "res://assets/ui/overlays/crt_wear_overlay.png"
const ASSET_WATERMARK := "res://assets/ui/overlays/terminal_watermark.png"
const ASSET_GLASS := "res://assets/ui/overlays/glass_overlay.png"
const ASSET_PANEL_FRAME := "res://assets/ui/panels/panel_frame_9patch.png"
const ASSET_BUTTON_APPROVE := "res://assets/ui/buttons/button_approve_9patch.png"
const ASSET_BUTTON_REJECT := "res://assets/ui/buttons/button_reject_9patch.png"

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
	_install_visual_layers()
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
	correct_label.text   = "Expedientes validados:  %d" % correct
	errors_label.text    = "Expedientes observados: %d" % errors
	credits_label.text   = "Creditos finales:     %d" % credits

	if errors > 0:
		errors_label.add_theme_color_override("font_color", COLOR_ERROR)
	if credits < 30:
		credits_label.add_theme_color_override("font_color", COLOR_ERROR)

	for decision in summary.get("decisions", []):
		_add_audit_block(decision)

	var day: int = summary.get("day", 1)
	_report = NarrativeConsequenceSystem.evaluate(summary, day)
	_selected_terminal = TerminalEndingSystem.evaluate(summary)
	if not _selected_terminal.is_empty():
		_is_terminal = true
		_show_terminal_ending(_selected_terminal)
	else:
		_show_normal_report(_report)

func _show_normal_report(report: Dictionary) -> void:
	var perf: Dictionary = report.get("performance", {})
	consequence_title_label.text = str(perf.get("title", "TURNO REGISTRADO"))

	var text: String = str(perf.get("body", ""))

	var incidents: Array = report.get("incidents", [])
	if not incidents.is_empty():
		text += "\n\n— INCIDENTES DEL TURNO —"
		var shown := 0
		for inc in incidents:
			if shown >= 3:
				text += "\n[...y %d incidentes adicionales en expediente]" % (incidents.size() - 3)
				break
			text += "\n• " + str(inc.get("summary_text", inc.get("title", "Incidente registrado.")))
			shown += 1

	var synthesis: String = report.get("synthesis", "")
	if synthesis != "":
		text += "\n\n" + synthesis

	var symptom := NarrativeStateSystem.get_narrative_symptom()
	if symptom != "":
		text += "\n\n" + symptom

	consequence_text.text = text

func _add_audit_block(decision: Dictionary) -> void:
	var was_correct: bool   = decision.get("was_correct", false)
	var name: String        = decision.get("applicant_name", "?")
	var dec: String         = decision.get("decision", "approve")
	var delta: int          = decision.get("credit_delta", 0)
	var report: Dictionary  = decision.get("report", {})
	var dec_label: String   = _DECISION_LABELS.get(dec, dec.to_upper())
	var correct_dec: String = decision.get("correct_decision", "")
	var correct_label_str: String = _DECISION_LABELS.get(correct_dec, correct_dec.to_upper())

	var header_color: Color = COLOR_OK if was_correct else COLOR_ERROR
	var header_prefix: String = "EXPEDIENTE VALIDADO" if was_correct else "EXPEDIENTE OBSERVADO"
	_add_block_line("%s — %s" % [header_prefix, name], header_color, 13)
	_add_block_line("  Accion registrada:  %s" % dec_label, COLOR_DIM, 12)

	if was_correct:
		var note: String = str(report.get("correct_note", ""))
		if note != "":
			_add_block_line("  Resultado: %s" % note, COLOR_DIM, 12)
		if delta == 0:
			_add_block_line("  Sin sancion.", COLOR_DIM, 12)
	else:
		var note: String = str(report.get("wrong_note", ""))
		if note != "":
			_add_block_line("  Observacion: %s" % note, COLOR_ERROR.lightened(0.15), 12)
		if correct_dec != "":
			_add_block_line("  Accion protocolaria omitida: %s" % correct_label_str, COLOR_DIM, 12)
		if delta < 0:
			_add_block_line("  Sancion aplicada: %d creditos" % delta, COLOR_ERROR, 12)

	var spacer := Label.new()
	spacer.text = " "
	spacer.add_theme_font_size_override("font_size", 5)
	decisions_list.add_child(spacer)

func _add_block_line(text: String, color: Color, size: int) -> void:
	var lbl := Label.new()
	lbl.text = text
	lbl.add_theme_color_override("font_color", color)
	lbl.add_theme_font_size_override("font_size", size)
	lbl.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	decisions_list.add_child(lbl)

func _apply_theme() -> void:
	_style_panel($VBox/Header, COLOR_PANEL, COLOR_BORDER)
	_style_panel($VBox/ScrollArea/ContentVBox/SummaryPanel, COLOR_PANEL, COLOR_BORDER)
	_style_panel($VBox/ScrollArea/ContentVBox/DecisionsPanel, COLOR_PANEL, COLOR_BORDER)
	_style_panel($VBox/ScrollArea/ContentVBox/ConsequencePanel, COLOR_PANEL, COLOR_BORDER)
	_style_panel($VBox/Footer, COLOR_PANEL, COLOR_BORDER)
	_apply_labels_color(self)

	var s_btn: StyleBox = _make_button_style(ASSET_BUTTON_APPROVE, COLOR_BTN)
	var s_hover: StyleBox = _make_button_style(ASSET_BUTTON_APPROVE, COLOR_BTN.lightened(0.2))
	restart_btn.add_theme_stylebox_override("normal", s_btn)
	restart_btn.add_theme_stylebox_override("hover", s_hover)
	restart_btn.add_theme_color_override("font_color", COLOR_TEXT)

func _style_panel(panel: PanelContainer, bg: Color, border: Color) -> void:
	var textured := _make_texture_style(ASSET_PANEL_FRAME, 14, 8)
	if textured != null:
		panel.add_theme_stylebox_override("panel", textured)
		return
	var style := StyleBoxFlat.new()
	style.bg_color = bg
	style.border_color = border
	style.set_border_width_all(1)
	style.set_content_margin_all(10)
	panel.add_theme_stylebox_override("panel", style)

func _install_visual_layers() -> void:
	_add_full_rect_texture(ASSET_TERMINAL_BG, -10, 1.0, "TerminalBackground")
	_add_full_rect_texture(ASSET_WATERMARK, 5, 0.20, "TerminalWatermark")
	_add_full_rect_texture(ASSET_SCANLINES, 90, 0.10, "ScanlineOverlay")
	_add_full_rect_texture(ASSET_CRT_WEAR, 91, 0.12, "CrtWearOverlay")
	_add_full_rect_texture(ASSET_GRIME, 92, 0.24, "GrimeOverlay")
	_add_full_rect_texture(ASSET_GLASS, 93, 0.34, "GlassOverlay")

func _add_full_rect_texture(path: String, z: int, alpha: float, node_name: String) -> void:
	if get_node_or_null(node_name) != null:
		return
	var texture := load(path)
	if texture == null:
		return
	var rect := TextureRect.new()
	rect.name = node_name
	rect.texture = texture
	rect.stretch_mode = TextureRect.STRETCH_SCALE
	rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	rect.z_index = z
	rect.modulate = Color(1, 1, 1, alpha)
	rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	add_child(rect)
	if node_name == "TerminalBackground":
		move_child(rect, 1)

func _make_texture_style(path: String, content_margin: int, texture_margin: int) -> StyleBoxTexture:
	var texture := load(path)
	if texture == null:
		return null
	var style := StyleBoxTexture.new()
	style.texture = texture
	style.set_texture_margin_all(texture_margin)
	style.set_content_margin_all(content_margin)
	style.draw_center = true
	return style

func _make_button_style(path: String, color: Color) -> StyleBox:
	var textured := _make_texture_style(path, 10, 8)
	if textured != null:
		textured.modulate_color = color.lightened(0.08)
		return textured
	var flat := StyleBoxFlat.new()
	flat.bg_color = color
	flat.border_color = color.lightened(0.3)
	flat.set_border_width_all(1)
	flat.set_content_margin_all(8)
	return flat

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
	var s: StyleBox = _make_button_style(ASSET_BUTTON_REJECT, Color(0.04, 0.16, 0.36, 1))
	var s_hover: StyleBox = _make_button_style(ASSET_BUTTON_REJECT, Color(0.06, 0.24, 0.52, 1))
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
			var nflag: String = d.get("narrative_flag", "")
			if nflag != "":
				lines.append("     flag:    %s" % nflag)
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

	lines.append("--- DICTAMEN DE RENDIMIENTO ---")
	var perf: Dictionary = _report.get("performance", {})
	if perf.is_empty() or perf.get("id", "") == "neutral":
		lines.append("  (neutral — sin coincidencia)")
	else:
		lines.append("  id:       %s" % perf.get("id", "?"))
		lines.append("  priority: %d" % perf.get("priority", 0))
		lines.append("  tone:     %s" % perf.get("tone", "?"))
		lines.append("  title:    %s" % perf.get("title", "?"))
	lines.append("")

	lines.append("--- INCIDENTES DE CASO ---")
	var incidents: Array = _report.get("incidents", [])
	if incidents.is_empty():
		lines.append("  (ninguno)")
	else:
		for inc in incidents:
			lines.append("  • %s" % inc.get("id", "?"))
			lines.append("    flag:     %s" % str(inc.get("trigger_flag", "?")))
			lines.append("    tone:     %s  severity: %s" % [inc.get("tone", "?"), inc.get("severity", "?")])
			lines.append("    priority: %d" % inc.get("priority", 0))
	lines.append("")

	lines.append("--- SINTESIS ---")
	var synthesis: String = _report.get("synthesis", "")
	lines.append("  %s" % (synthesis if synthesis != "" else "(sin incidentes — sin sintesis)"))
	lines.append("")

	lines.append("--- EFECTOS APLICADOS ---")
	var applied: Dictionary = _report.get("effects_applied", {})
	if applied.is_empty():
		lines.append("  (ninguno)")
	else:
		for k in applied:
			lines.append("  %s: %+d" % [k, applied[k]])
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
