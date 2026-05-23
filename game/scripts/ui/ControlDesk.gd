class_name ControlDesk
extends Control

static var day_to_load: int = 1

const COLOR_BG := Color(0.03, 0.05, 0.03, 1)
const COLOR_PANEL := Color(0.06, 0.10, 0.06, 1)
const COLOR_PANEL_DARK := Color(0.02, 0.04, 0.02, 1)
const COLOR_BORDER := Color(0.15, 0.45, 0.15, 1)
const COLOR_TEXT := Color(0.18, 0.82, 0.18, 1)
const COLOR_TEXT_DIM := Color(0.35, 0.55, 0.35, 1)
const COLOR_APPROVE := Color(0.08, 0.42, 0.08, 1)
const COLOR_HOLD := Color(0.42, 0.32, 0.04, 1)
const COLOR_REJECT := Color(0.42, 0.06, 0.06, 1)
const COLOR_TOOL := Color(0.05, 0.20, 0.30, 1)
const COLOR_QUESTION := Color(0.04, 0.14, 0.22, 1)

const ASSET_TERMINAL_BG := "res://assets/ui/terminal/terminal_background.png"
const ASSET_SCANLINES := "res://assets/ui/overlays/scanline_overlay.png"
const ASSET_PANEL_FRAME := "res://assets/ui/panels/panel_frame_9patch.png"
const ASSET_DOCUMENT_VIEW := "res://assets/ui/panels/document_view_9patch.png"
const ASSET_SCANNER_FRAME := "res://assets/ui/panels/scanner_frame_9patch.png"
const ASSET_BUTTON_APPROVE := "res://assets/ui/buttons/button_approve_9patch.png"
const ASSET_BUTTON_HOLD := "res://assets/ui/buttons/button_hold_9patch.png"
const ASSET_BUTTON_REJECT := "res://assets/ui/buttons/button_reject_9patch.png"
const ASSET_BUTTON_TOOL := "res://assets/ui/buttons/button_tool_9patch.png"

@onready var day_label: Label = $VBox/StatusBar/StatusHBox/DayLabel
@onready var credits_label: Label = $VBox/StatusBar/StatusHBox/CreditsLabel
@onready var panel_title: Label = $VBox/MainArea/ApplicantPanel/ApplicantVBox/PanelTitle
@onready var applicant_name: Label = $VBox/MainArea/ApplicantPanel/ApplicantVBox/ApplicantName
@onready var applicant_origin: Label = $VBox/MainArea/ApplicantPanel/ApplicantVBox/ApplicantOrigin
@onready var applicant_destination: Label = $VBox/MainArea/ApplicantPanel/ApplicantVBox/ApplicantDestination
@onready var applicant_purpose: Label = $VBox/MainArea/ApplicantPanel/ApplicantVBox/ApplicantPurpose
@onready var dialogue_text: Label = $VBox/MainArea/ApplicantPanel/ApplicantVBox/DialogueText
@onready var doc_content: Label = $VBox/MainArea/DocumentArea/DocumentVBox/DocumentView/DocContent
@onready var alerts_list: Label = $VBox/MainArea/ToolsPanel/ToolsVBox/AlertsContainer/AlertsList
@onready var _tab_alertas: Button = $VBox/MainArea/ToolsPanel/ToolsVBox/ToolsTabHBox/TabAlertas
@onready var _tab_regs: Button = $VBox/MainArea/ToolsPanel/ToolsVBox/ToolsTabHBox/TabRegs
@onready var _alerts_container: VBoxContainer = $VBox/MainArea/ToolsPanel/ToolsVBox/AlertsContainer
@onready var _regs_container: VBoxContainer = $VBox/MainArea/ToolsPanel/ToolsVBox/RegsContainer
@onready var approve_btn: Button = $VBox/DecisionBar/DecisionHBox/ApproveButton
@onready var hold_btn: Button = $VBox/DecisionBar/DecisionHBox/HoldButton
@onready var reject_btn: Button = $VBox/DecisionBar/DecisionHBox/RejectButton
@onready var scanner_btn: Button = $VBox/MainArea/ToolsPanel/ToolsVBox/ScannerButton
@onready var tab1: Button = $VBox/MainArea/DocumentArea/DocumentVBox/DocTabs/Tab1
@onready var tab2: Button = $VBox/MainArea/DocumentArea/DocumentVBox/DocTabs/Tab2
@onready var tab3: Button = $VBox/MainArea/DocumentArea/DocumentVBox/DocTabs/Tab3
@onready var applicant_vbox: VBoxContainer = $VBox/MainArea/ApplicantPanel/ApplicantVBox
@onready var tools_vbox: VBoxContainer = $VBox/MainArea/ToolsPanel/ToolsVBox

var current_day: int = 1
var credits: int = 50
var day_data: Dictionary = {}
var applicants: Array = []
var documents: Dictionary = {}
var rules: Array = []
var queue: ApplicantQueue
var decision_system: DecisionSystem
var _applicant_docs: Dictionary = {}
var _scanner_used: bool = false
var _tab3_doc_type: String = ""
var _questions_container: VBoxContainer
var _audio: AudioStreamPlayer

# --- Estado interno para debug ---
var _current_applicant: Dictionary = {}
var _last_violations: Array = []
var _last_decision_result: Dictionary = {}
var _debug_panel: PanelContainer
var _debug_label: Label

func _ready() -> void:
	_install_visual_layers()
	_apply_theme()
	_setup_tools_tabs()
	approve_btn.text = "APROBAR (A)"
	reject_btn.text  = "RECHAZAR (D)"
	hold_btn.text    = "RETENER (S)\nEnviar a revision"
	hold_btn.tooltip_text = "Usar cuando el expediente requiera verificacion adicional, custodia temporal o revision superior."
	hold_btn.add_theme_font_size_override("font_size", 15)
	_connect_signals()
	current_day = ControlDesk.day_to_load
	_update_status_bar()
	_reset_applicant_panel()
	_setup_questions_area()
	_audio = SoundManager.create_player(self)
	_build_debug_panel()
	NarrativeStateSystem.snapshot()
	_load_day_data()

func _load_day_data() -> void:
	day_data = DataLoader.load_day(current_day)
	applicants = DataLoader.load_applicants(current_day)
	documents = DataLoader.load_documents(current_day)
	rules = DataLoader.load_rules(current_day)
	print("[ControlDesk] Dia %d cargado — %d solicitantes, %d documentos, %d reglas" % [
		current_day, applicants.size(), documents.size(), rules.size()
	])
	credits = day_data.get("credits_start", 50)
	decision_system = DecisionSystem.new()
	add_child(decision_system)
	decision_system.setup(credits)
	decision_system.decision_recorded.connect(_on_decision_recorded)

	queue = ApplicantQueue.new()
	add_child(queue)
	queue.applicant_changed.connect(_on_applicant_changed)
	queue.day_ended.connect(_on_day_ended)
	_update_status_bar()
	_build_regulations_section()
	queue.load_applicants(applicants)
	queue.start()

func _on_applicant_changed(applicant: Dictionary) -> void:
	_current_applicant = applicant
	_last_decision_result = {}
	var pos := queue.get_current_index() + 1
	var total := queue.get_total()
	panel_title.text = "SOLICITANTE %d / %d" % [pos, total]
	applicant_name.text = applicant.get("name", "---")
	applicant_origin.text = "Origen: " + applicant.get("origin", "---")
	applicant_destination.text = "Destino: " + applicant.get("destination", "---")
	applicant_purpose.text = "Motivo: " + applicant.get("purpose", "---")
	dialogue_text.text = applicant.get("dialogue_intro", "---")
	_set_decision_buttons_enabled(true)
	_reset_scanner()
	_load_applicant_documents(applicant)
	_run_rules(applicant)
	_reset_questions(applicant)
	if _debug_panel != null and _debug_panel.visible:
		_update_debug_panel(applicant)

func _on_day_ended(total: int) -> void:
	panel_title.text = "TURNO CERRADO"
	applicant_name.text = "--- FIN DEL TURNO ---"
	applicant_origin.text = "Procesados: %d / %d" % [total, applicants.size()]
	applicant_destination.text = ""
	applicant_purpose.text = ""
	dialogue_text.text = "El turno ha concluido.\nGenerando reporte..."
	doc_content.text = "[ Sin caso activo ]"
	alerts_list.text = "---"
	_set_decision_buttons_enabled(false)
	for btn in _questions_container.get_children():
		if btn is Button:
			btn.disabled = true
	print("[ControlDesk] Turno terminado — %d / %d procesados" % [total, applicants.size()])
	await get_tree().create_timer(1.5).timeout
	var summary := decision_system.get_summary()
	summary["quota"] = applicants.size()
	summary["day"] = current_day
	DayReport.pending_summary = summary
	get_tree().change_scene_to_file("res://scenes/main/DayReport.tscn")

func _set_decision_buttons_enabled(enabled: bool) -> void:
	approve_btn.disabled = not enabled
	hold_btn.disabled = not enabled
	reject_btn.disabled = not enabled

func _apply_theme() -> void:
	_style_panel($VBox/StatusBar, COLOR_PANEL, COLOR_BORDER)
	_style_panel($VBox/MainArea/ApplicantPanel, COLOR_PANEL, COLOR_BORDER)
	_style_panel($VBox/MainArea/DocumentArea, COLOR_PANEL, COLOR_BORDER)
	_style_panel($VBox/MainArea/ToolsPanel, COLOR_PANEL, COLOR_BORDER)
	_style_panel($VBox/DecisionBar, COLOR_PANEL, COLOR_BORDER)
	_style_document_view(false)
	_style_button(approve_btn, COLOR_APPROVE, ASSET_BUTTON_APPROVE)
	_style_button(hold_btn, COLOR_HOLD, ASSET_BUTTON_HOLD)
	_style_button(reject_btn, COLOR_REJECT, ASSET_BUTTON_REJECT)
	_style_button(scanner_btn, COLOR_TOOL, ASSET_BUTTON_TOOL)
	_apply_labels_color(self)
	_style_tab_buttons()

func _style_panel(panel: PanelContainer, bg: Color, border: Color) -> void:
	var textured := _make_texture_style(ASSET_PANEL_FRAME, 14, 8)
	if textured != null:
		panel.add_theme_stylebox_override("panel", textured)
		return
	var style := StyleBoxFlat.new()
	style.bg_color = bg
	style.border_color = border
	style.set_border_width_all(1)
	style.set_content_margin_all(8)
	panel.add_theme_stylebox_override("panel", style)

func _style_button(btn: Button, color: Color, texture_path: String = "") -> void:
	var s_normal: StyleBox = _make_button_style(texture_path, color)
	var s_hover: StyleBox = _make_button_style(texture_path, color.lightened(0.18))
	var s_pressed: StyleBox = _make_button_style(texture_path, color.darkened(0.18))
	var s_disabled: StyleBox = _make_button_style(texture_path, color.darkened(0.45))

	btn.add_theme_stylebox_override("normal", s_normal)
	btn.add_theme_stylebox_override("hover", s_hover)
	btn.add_theme_stylebox_override("pressed", s_pressed)
	btn.add_theme_stylebox_override("disabled", s_disabled)
	btn.add_theme_color_override("font_color", Color(0.9, 0.95, 0.9, 1))
	btn.add_theme_color_override("font_hover_color", Color(1.0, 1.0, 1.0, 1))
	btn.add_theme_color_override("font_disabled_color", Color(0.4, 0.45, 0.4, 1))

func _install_visual_layers() -> void:
	_add_full_rect_texture(ASSET_TERMINAL_BG, -10, 1.0, "TerminalBackground")
	_add_full_rect_texture(ASSET_SCANLINES, 90, 0.22, "ScanlineOverlay")

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
		textured.modulate_color = color.lightened(0.35)
		return textured
	var flat := StyleBoxFlat.new()
	flat.bg_color = color
	flat.border_color = color.lightened(0.3)
	flat.set_border_width_all(1)
	flat.set_content_margin_all(8)
	return flat

func _style_document_view(scanner_mode: bool) -> void:
	var path := ASSET_SCANNER_FRAME if scanner_mode else ASSET_DOCUMENT_VIEW
	var textured := _make_texture_style(path, 16, 8)
	if textured != null:
		$VBox/MainArea/DocumentArea/DocumentVBox/DocumentView.add_theme_stylebox_override("panel", textured)
		return
	_style_panel($VBox/MainArea/DocumentArea/DocumentVBox/DocumentView, COLOR_PANEL_DARK, COLOR_BORDER)

func _apply_labels_color(node: Node) -> void:
	for child in node.get_children():
		if child is Label:
			child.add_theme_color_override("font_color", COLOR_TEXT)
		_apply_labels_color(child)

func _connect_signals() -> void:
	approve_btn.pressed.connect(_on_approve_pressed)
	hold_btn.pressed.connect(_on_hold_pressed)
	reject_btn.pressed.connect(_on_reject_pressed)
	scanner_btn.pressed.connect(_on_scanner_pressed)
	tab1.pressed.connect(func(): _show_doc_by_type("transit_pass", tab1))
	tab2.pressed.connect(func(): _show_doc_by_type("bio_cert", tab2))
	tab3.pressed.connect(func(): _show_doc_by_type(_tab3_doc_type, tab3))

func _input(event: InputEvent) -> void:
	if not (event is InputEventKey and event.pressed and not event.echo):
		return
	var handled := true
	match event.keycode:
		KEY_Y:
			_debug_panel.visible = not _debug_panel.visible
			if _debug_panel.visible and not _current_applicant.is_empty():
				_update_debug_panel(_current_applicant)
		KEY_A:
			if not approve_btn.disabled: _on_approve_pressed()
		KEY_S:
			if not hold_btn.disabled:    _on_hold_pressed()
		KEY_D:
			if not reject_btn.disabled:  _on_reject_pressed()
		KEY_E:
			if not scanner_btn.disabled: _on_scanner_pressed()
		KEY_Q:
			_press_next_question()
		_:
			handled = false
	if handled:
		get_viewport().set_input_as_handled()

func _update_status_bar() -> void:
	var current_date: String = day_data.get("current_date", "")
	var date_str := ("  —  CICLO %s" % current_date) if current_date != "" else ""
	day_label.text = "DIA %d%s" % [current_day, date_str]
	credits_label.text = "CREDITOS: %d" % credits

func _reset_applicant_panel() -> void:
	panel_title.text = "SOLICITANTE"
	applicant_name.text = "--- EN ESPERA ---"
	applicant_origin.text = "Origen: ---"
	applicant_destination.text = "Destino: ---"
	applicant_purpose.text = "Motivo: ---"
	dialogue_text.text = "Cargando turno..."
	doc_content.text = "[ Sin documento activo ]"
	alerts_list.text = "--- Sin alertas ---"
	_set_decision_buttons_enabled(false)

func _on_approve_pressed() -> void:
	_make_decision("approve")

func _on_hold_pressed() -> void:
	_make_decision("hold")

func _on_reject_pressed() -> void:
	_make_decision("reject")

func _make_decision(decision: String) -> void:
	var applicant := queue.get_current()
	if applicant.is_empty():
		return
	_set_decision_buttons_enabled(false)
	decision_system.record(decision, applicant)
	await get_tree().create_timer(0.6).timeout
	queue.advance()

func _on_decision_recorded(result: Dictionary) -> void:
	credits = decision_system.get_credits()
	_update_status_bar()
	var label := "APROBADO" if result["decision"] == "approve" \
		else ("RETENIDO" if result["decision"] == "hold" else "RECHAZADO")
	var lines: Array = [
		"[ %s ]" % label,
		"",
		"Correctas : %d" % decision_system.get_correct(),
		"Errores   : %d" % decision_system.get_errors(),
		"Creditos  : %d" % credits,
	]
	if result["credit_delta"] < 0:
		lines.append("")
		lines.append("Penalizacion: %d creditos" % result["credit_delta"])
	doc_content.text = "\n".join(lines)
	_last_decision_result = result
	if _debug_panel != null and _debug_panel.visible:
		_update_debug_panel(_current_applicant)
	_play_decision_sound(result["decision"])
	_flash_decision_bar(result["decision"])
	if result["credit_delta"] < 0:
		_flash_credits_label()
	print("[Decision] %s — %s | Correcto: %s | Delta: %d" % [
		result["decision"].to_upper(),
		result["applicant_name"],
		str(result["was_correct"]),
		result["credit_delta"]
	])

func _on_scanner_pressed() -> void:
	if _scanner_used or queue.get_current().is_empty():
		return
	_scanner_used = true
	scanner_btn.disabled = true
	scanner_btn.text = "ESCANEANDO..."
	SoundManager.play_scan(_audio)
	await get_tree().create_timer(0.4).timeout
	_show_scan_results()
	scanner_btn.text = "[ ESCANER USADO ]"

func _show_scan_results() -> void:
	_style_document_view(true)
	var applicant := queue.get_current()
	var flags: Array = applicant.get("flags", [])
	var risk: String = applicant.get("truth", {}).get("risk_level", "low")

	var lines: Array = [
		"=== INFORME DE ESCANER — UMBRAL 7 ===",
		"",
		"SUJETO:  " + applicant.get("name", "?"),
		"ORIGEN:  " + applicant.get("origin", "?"),
		"",
	]

	var alert_texts: Array = []
	if flags.is_empty():
		lines.append("RESULTADO: SIN ANOMALIAS DETECTADAS")
		alert_texts.append("ESCANER: Sin anomalias")
	else:
		lines.append("ANOMALIAS DETECTADAS:")
		lines.append("")
		for flag in flags:
			var desc := _flag_description(flag)
			lines.append("  ! " + desc)
			alert_texts.append("! " + desc)

	lines.append("")
	lines.append(_risk_line(risk))
	doc_content.text = "\n".join(lines)

	var rule_alerts: String = alerts_list.text
	var scanner_block: String = "\n".join(alert_texts)
	if rule_alerts == "Sin irregularidades.":
		alerts_list.text = scanner_block
	else:
		alerts_list.text = rule_alerts + "\n---\n" + scanner_block

	print("[Escaner] %s — Flags: %s" % [applicant.get("name", "?"), str(flags)])

func _reset_scanner() -> void:
	_scanner_used = false
	scanner_btn.text = "[ ESCANER ] (E)"
	scanner_btn.disabled = false

func _flag_description(flag: String) -> String:
	match flag:
		"biological_anomaly":  return "Anomalia biologica detectada"
		"suspicious_dialogue": return "Patron de respuesta irregular"
		"undeclared_device":   return "Objeto no declarado en permiso"
		"cargo_mismatch":      return "Contenido no coincide con declaracion"
		"missing_seal":        return "Sello de autoridad ausente"
		"expired_document":    return "Documento con fecha vencida"
	return "Irregularidad no clasificada"

func _risk_line(risk: String) -> String:
	match risk:
		"high":   return "NIVEL DE RIESGO: ALTO\nRECOMENDACION: RETENER INMEDIATAMENTE"
		"medium": return "NIVEL DE RIESGO: MEDIO\nRECOMENDACION: RETENER PARA REVISION"
		"low":    return "NIVEL DE RIESGO: BAJO\nRECOMENDACION: PROCEDER CON CRITERIO"
	return "NIVEL DE RIESGO: INDETERMINADO"

func _run_rules(applicant: Dictionary) -> void:
	var current_date: String = day_data.get("current_date", "298.12")
	var violations := RuleEngine.evaluate(_applicant_docs, rules, current_date)
	_last_violations = violations
	if violations.is_empty():
		alerts_list.text = "Sin irregularidades."
		return
	var lines: Array = []
	for v in violations:
		lines.append("! " + v.get("description", "Violacion"))
		if v.get("detail", "") != "":
			lines.append("  " + v["detail"])
	alerts_list.text = "\n".join(lines)
	print("[RuleEngine] %d violacion(es) — %s" % [violations.size(), applicant.get("name", "?")])

# --- Sistema de documentos ---

func _load_applicant_documents(applicant: Dictionary) -> void:
	_style_document_view(false)
	_applicant_docs = {}
	for doc_id in applicant.get("documents", []):
		if documents.has(doc_id):
			var doc: Dictionary = documents[doc_id]
			_applicant_docs[doc.get("type", "")] = doc
	tab1.disabled = not _applicant_docs.has("transit_pass")
	tab2.disabled = not _applicant_docs.has("bio_cert")
	_tab3_doc_type = ""
	for dtype in _applicant_docs:
		if dtype not in ["transit_pass", "bio_cert"]:
			_tab3_doc_type = dtype
			break
	tab3.disabled = _tab3_doc_type == ""
	if _tab3_doc_type != "":
		tab3.text = _doc_type_tab_label(_tab3_doc_type)
	# Mostrar primer documento disponible
	if _applicant_docs.has("transit_pass"):
		_show_doc_by_type("transit_pass", tab1)
	elif _applicant_docs.has("bio_cert"):
		_show_doc_by_type("bio_cert", tab2)
	elif _tab3_doc_type != "":
		_show_doc_by_type(_tab3_doc_type, tab3)
	else:
		doc_content.text = "[ Sin documentos ]"

func _doc_type_tab_label(dtype: String) -> String:
	match dtype:
		"ingress_permit": return "PERMISO"
	return dtype.to_upper().left(12)

func _show_doc_by_type(dtype: String, active_btn: Button) -> void:
	if not _applicant_docs.has(dtype):
		return
	_style_document_view(false)
	_set_active_tab(active_btn)
	_render_document(_applicant_docs[dtype])

func _set_active_tab(active_btn: Button) -> void:
	for tab in [tab1, tab2, tab3]:
		var is_active: bool = (tab == active_btn)
		var s := StyleBoxFlat.new()
		s.bg_color = Color(0.10, 0.22, 0.10, 1) if is_active else Color(0.05, 0.10, 0.05, 1)
		s.border_color = COLOR_TEXT if is_active else COLOR_BORDER
		s.set_border_width_all(2 if is_active else 1)
		s.set_content_margin_all(6)
		tab.add_theme_stylebox_override("normal", s)
		tab.add_theme_color_override("font_color", COLOR_TEXT if is_active else COLOR_TEXT_DIM)

func _render_document(doc: Dictionary) -> void:
	var label: String = doc.get("label", "DOCUMENTO")
	var fields: Dictionary = doc.get("fields", {})
	var lines: Array = ["=== %s ===" % label.to_upper(), ""]
	for key in fields:
		var k: String = str(key).replace("_", " ").to_upper()
		lines.append("%s: %s" % [k, str(fields[key])])
	doc_content.text = "\n".join(lines)

# --- Feedback visual y sonoro ---

func _play_decision_sound(decision: String) -> void:
	match decision:
		"approve": SoundManager.play_approve(_audio)
		"reject":  SoundManager.play_reject(_audio)
		"hold":    SoundManager.play_hold(_audio)

func _flash_decision_bar(decision: String) -> void:
	var flash := Color(0.9, 1.0, 0.9, 1)
	match decision:
		"reject": flash = Color(1.0, 0.88, 0.88, 1)
		"hold":   flash = Color(1.0, 0.96, 0.82, 1)
	$VBox/DecisionBar.modulate = flash
	var tween := create_tween()
	tween.tween_property($VBox/DecisionBar, "modulate", Color.WHITE, 0.35)

func _flash_credits_label() -> void:
	credits_label.add_theme_color_override("font_color", Color.WHITE)
	var tween := create_tween()
	tween.tween_interval(0.2)
	tween.tween_callback(func(): credits_label.add_theme_color_override("font_color", COLOR_TEXT))

# --- Sistema de preguntas ---

func _setup_questions_area() -> void:
	var sep := HSeparator.new()
	applicant_vbox.add_child(sep)

	var title := Label.new()
	title.text = "PREGUNTAS"
	title.add_theme_font_size_override("font_size", 11)
	title.add_theme_color_override("font_color", COLOR_TEXT_DIM)
	applicant_vbox.add_child(title)

	_questions_container = VBoxContainer.new()
	_questions_container.add_theme_constant_override("separation", 4)
	applicant_vbox.add_child(_questions_container)

func _reset_questions(applicant: Dictionary) -> void:
	for child in _questions_container.get_children():
		_questions_container.remove_child(child)
		child.free()

	var questions: Dictionary = applicant.get("questions", {})
	var question_alerts: Dictionary = applicant.get("question_alerts", {})
	var question_labels := {
		"motivo": "[ ¿Cual es el motivo? ] (Q)",
		"origen": "[ ¿De donde proviene? ] (Q)",
		"carga":  "[ ¿Que lleva consigo? ] (Q)"
	}
	for key in ["motivo", "origen", "carga"]:
		if not questions.has(key):
			continue
		var response: String = questions[key]
		var alert: String = question_alerts.get(key, "")
		var btn := Button.new()
		btn.text = question_labels[key]
		btn.alignment = HORIZONTAL_ALIGNMENT_LEFT
		_style_question_button(btn)
		btn.pressed.connect(_on_question_asked.bind(key, response, alert, btn))
		_questions_container.add_child(btn)

func _style_question_button(btn: Button) -> void:
	var s_normal := StyleBoxFlat.new()
	s_normal.bg_color = COLOR_QUESTION
	s_normal.border_color = COLOR_TEXT_DIM
	s_normal.set_border_width_all(1)
	s_normal.set_content_margin_all(6)
	var s_hover := StyleBoxFlat.new()
	s_hover.bg_color = COLOR_QUESTION.lightened(0.15)
	s_hover.border_color = COLOR_TEXT
	s_hover.set_border_width_all(1)
	s_hover.set_content_margin_all(6)
	var s_disabled := StyleBoxFlat.new()
	s_disabled.bg_color = COLOR_QUESTION.darkened(0.4)
	s_disabled.border_color = COLOR_QUESTION.darkened(0.2)
	s_disabled.set_border_width_all(1)
	s_disabled.set_content_margin_all(6)
	btn.add_theme_stylebox_override("normal", s_normal)
	btn.add_theme_stylebox_override("hover", s_hover)
	btn.add_theme_stylebox_override("disabled", s_disabled)
	btn.add_theme_color_override("font_color", COLOR_TEXT)
	btn.add_theme_color_override("font_hover_color", Color(1.0, 1.0, 1.0, 1))
	btn.add_theme_color_override("font_disabled_color", COLOR_TEXT_DIM)
	btn.add_theme_font_size_override("font_size", 12)

func _press_next_question() -> void:
	for btn in _questions_container.get_children():
		if btn is Button and not btn.disabled:
			btn.pressed.emit()
			return

func _on_question_asked(key: String, response: String, alert: String, btn: Button) -> void:
	dialogue_text.text = response
	btn.disabled = true
	if alert != "":
		var current_alerts: String = alerts_list.text
		if current_alerts in ["Sin irregularidades.", "--- Sin alertas ---"]:
			alerts_list.text = alert
		else:
			alerts_list.text = current_alerts + "\n" + alert
		SoundManager.play_alert(_audio)
		print("[Pregunta] ALERTA — %s: %s" % [key, alert])

# --- Panel de debug interno (solo desarrollo) ---

func _build_debug_panel() -> void:
	_debug_panel = PanelContainer.new()
	_debug_panel.visible = false
	_debug_panel.z_index = 100
	_debug_panel.mouse_filter = Control.MOUSE_FILTER_PASS
	# Posición: cubre el lado izquierdo (sobre el panel de solicitante)
	_debug_panel.set_anchor_and_offset(SIDE_LEFT,   0.0,  4)
	_debug_panel.set_anchor_and_offset(SIDE_RIGHT,  0.0,  394)
	_debug_panel.set_anchor_and_offset(SIDE_TOP,    0.0,  4)
	_debug_panel.set_anchor_and_offset(SIDE_BOTTOM, 1.0, -4)

	var style := StyleBoxFlat.new()
	style.bg_color = Color(0.02, 0.04, 0.12, 0.93)
	style.border_color = Color(0.20, 0.60, 0.90, 1)
	style.set_border_width_all(2)
	style.set_content_margin_all(8)
	_debug_panel.add_theme_stylebox_override("panel", style)

	var vbox := VBoxContainer.new()

	var title := Label.new()
	title.text = "[ DEBUG — SOLO DESARROLLO ]  Y: ocultar"
	title.add_theme_font_size_override("font_size", 10)
	title.add_theme_color_override("font_color", Color(1.0, 0.75, 0.15, 1))
	title.mouse_filter = Control.MOUSE_FILTER_IGNORE

	# --- Navegacion rapida por dia ---
	var nav_label := Label.new()
	nav_label.text = "IR A DIA:"
	nav_label.add_theme_font_size_override("font_size", 10)
	nav_label.add_theme_color_override("font_color", Color(1.0, 0.75, 0.15, 1))
	nav_label.mouse_filter = Control.MOUSE_FILTER_IGNORE

	var nav_hbox := HBoxContainer.new()
	nav_hbox.add_theme_constant_override("separation", 4)
	for d in range(1, 10):
		var day_path := "res://data/days/day_%02d.json" % d
		if not FileAccess.file_exists(day_path):
			break
		var day_btn := Button.new()
		day_btn.text = "DIA %d" % d
		day_btn.add_theme_font_size_override("font_size", 11)
		var s_nav := StyleBoxFlat.new()
		s_nav.bg_color = Color(0.10, 0.06, 0.22, 1)
		s_nav.border_color = Color(0.55, 0.35, 0.90, 1)
		s_nav.set_border_width_all(1)
		s_nav.set_content_margin_all(4)
		var s_nav_h := StyleBoxFlat.new()
		s_nav_h.bg_color = Color(0.18, 0.10, 0.38, 1)
		s_nav_h.border_color = Color(0.75, 0.55, 1.0, 1)
		s_nav_h.set_border_width_all(1)
		s_nav_h.set_content_margin_all(4)
		day_btn.add_theme_stylebox_override("normal", s_nav)
		day_btn.add_theme_stylebox_override("hover",  s_nav_h)
		day_btn.add_theme_color_override("font_color", Color(0.85, 0.70, 1.0, 1))
		day_btn.pressed.connect(_jump_to_day.bind(d))
		nav_hbox.add_child(day_btn)

	var sep_nav := HSeparator.new()
	var sep := HSeparator.new()

	var scroll := ScrollContainer.new()
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	scroll.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	scroll.mouse_filter = Control.MOUSE_FILTER_IGNORE

	_debug_label = Label.new()
	_debug_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_debug_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_debug_label.add_theme_font_size_override("font_size", 11)
	_debug_label.add_theme_color_override("font_color", Color(0.55, 0.90, 1.0, 1))
	_debug_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_debug_label.text = "Sin caso activo."

	scroll.add_child(_debug_label)
	vbox.add_child(title)
	vbox.add_child(sep_nav)
	vbox.add_child(nav_label)
	vbox.add_child(nav_hbox)
	vbox.add_child(sep)
	vbox.add_child(scroll)
	_debug_panel.add_child(vbox)
	add_child(_debug_panel)

func _update_debug_panel(applicant: Dictionary) -> void:
	if _debug_label == null:
		return
	if applicant.is_empty():
		_debug_label.text = "Sin caso activo."
		return

	var truth: Dictionary = applicant.get("truth", {})
	var flags: Array    = applicant.get("flags", [])
	var q_alerts: Dictionary = applicant.get("question_alerts", {})

	var lines: Array = []
	lines.append("ID:       " + applicant.get("id", "No disponible"))
	lines.append("NOMBRE:   " + applicant.get("name", "No disponible"))
	lines.append("TIPO:     " + applicant.get("type", "No disponible"))
	lines.append("")
	lines.append("--- VERDAD OCULTA ---")
	var correct_dec: String = truth.get("correct_decision", "")
	lines.append("  [ %s ] APROBAR"  % ("X" if correct_dec == "approve" else " "))
	lines.append("  [ %s ] RETENER"  % ("X" if correct_dec == "hold"    else " "))
	lines.append("  [ %s ] RECHAZAR" % ("X" if correct_dec == "reject"  else " "))
	lines.append("Riesgo:   " + truth.get("risk_level", "No disponible").to_upper())
	lines.append("Notas:    " + truth.get("notes", "No disponible"))
	lines.append("")
	lines.append("--- DOCUMENTOS ---")
	var doc_keys := _applicant_docs.keys()
	if doc_keys.is_empty():
		lines.append("  (ninguno)")
	else:
		for d in doc_keys:
			lines.append("  • " + str(d))
	lines.append("")
	lines.append("--- FLAGS ---")
	if flags.is_empty():
		lines.append("  (ninguno)")
	else:
		for f in flags:
			lines.append("  ! " + str(f))
	lines.append("")
	lines.append("--- REGLAS FALLIDAS ---")
	if _last_violations.is_empty():
		lines.append("  (ninguna)")
	else:
		for v in _last_violations:
			lines.append("  ! " + v.get("description", "?"))
	lines.append("")
	lines.append("--- ALERTAS INTERROGATORIO ---")
	if q_alerts.is_empty():
		lines.append("  (ninguna)")
	else:
		for k in q_alerts.keys():
			lines.append("  [" + str(k).to_upper() + "]")
			lines.append("   " + str(q_alerts[k]))
	lines.append("")
	lines.append("--- ÚLTIMA DECISIÓN ---")
	if _last_decision_result.is_empty():
		lines.append("  (sin decisión aún)")
	else:
		var dec: String  = _last_decision_result.get("decision", "?").to_upper()
		var ok: bool     = _last_decision_result.get("was_correct", false)
		var delta: int   = _last_decision_result.get("credit_delta", 0)
		lines.append("  Decisión:  " + dec)
		lines.append("  Correcta:  " + ("SÍ" if ok else "NO"))
		if delta < 0:
			lines.append("  Créditos:  %d" % delta)
	lines.append("")
	lines.append("--- ACUMULADORES ---")
	var acc := NarrativeStateSystem.get_accumulators()
	for k in acc:
		lines.append("  %s: %d" % [k, acc[k]])

	_debug_label.text = "\n".join(lines)

func _setup_tools_tabs() -> void:
	_show_tools_tab("alertas")
	_tab_alertas.pressed.connect(func(): _show_tools_tab("alertas"))
	_tab_regs.pressed.connect(func():    _show_tools_tab("regs"))

func _show_tools_tab(tab: String) -> void:
	_alerts_container.visible = (tab == "alertas")
	_regs_container.visible   = (tab == "regs")
	_style_tools_tab_active(_tab_alertas, tab == "alertas")
	_style_tools_tab_active(_tab_regs,    tab == "regs")

func _style_tools_tab_active(btn: Button, active: bool) -> void:
	var s := StyleBoxFlat.new()
	s.bg_color    = Color(0.08, 0.18, 0.08, 1) if active else Color(0.03, 0.06, 0.03, 1)
	s.border_color = COLOR_TEXT if active else COLOR_BORDER
	s.set_border_width_all(1)
	s.set_content_margin_all(4)
	btn.add_theme_stylebox_override("normal", s)
	btn.add_theme_stylebox_override("hover",  s)
	btn.add_theme_color_override("font_color", COLOR_TEXT if active else COLOR_TEXT_DIM)

func _jump_to_day(day: int) -> void:
	NarrativeStateSystem.reset()
	ControlDesk.day_to_load = day
	get_tree().change_scene_to_file("res://scenes/main/ControlDesk.tscn")

func _build_regulations_section() -> void:
	for rule in rules:
		var display: String = rule.get("display_text", rule.get("description", ""))
		if display == "":
			continue
		var lbl := Label.new()
		lbl.text = display
		lbl.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
		lbl.add_theme_font_size_override("font_size", 10)
		lbl.add_theme_color_override("font_color", COLOR_TEXT_DIM)
		_regs_container.add_child(lbl)

func _style_tab_buttons() -> void:
	for tab in [tab1, tab2, tab3]:
		var s := StyleBoxFlat.new()
		s.bg_color = Color(0.05, 0.10, 0.05, 1)
		s.border_color = COLOR_BORDER
		s.set_border_width_all(1)
		s.set_content_margin_all(6)
		var s_hover := StyleBoxFlat.new()
		s_hover.bg_color = Color(0.08, 0.16, 0.08, 1)
		s_hover.border_color = COLOR_TEXT
		s_hover.set_border_width_all(1)
		s_hover.set_content_margin_all(6)
		var s_disabled := StyleBoxFlat.new()
		s_disabled.bg_color = Color(0.03, 0.05, 0.03, 1)
		s_disabled.border_color = Color(0.07, 0.12, 0.07, 1)
		s_disabled.set_border_width_all(1)
		s_disabled.set_content_margin_all(6)
		tab.add_theme_stylebox_override("normal", s)
		tab.add_theme_stylebox_override("hover", s_hover)
		tab.add_theme_stylebox_override("disabled", s_disabled)
		tab.add_theme_color_override("font_color", COLOR_TEXT_DIM)
		tab.add_theme_color_override("font_hover_color", COLOR_TEXT)
		tab.add_theme_color_override("font_disabled_color", Color(0.18, 0.28, 0.18, 1))
