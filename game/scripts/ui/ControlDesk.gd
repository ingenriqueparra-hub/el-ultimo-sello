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
const ASSET_DOCUMENT_SCANNER_FRAME := "res://assets/ui/panels/frame_document_scanner.png"
const ASSET_BUTTON_APPROVE := "res://assets/ui/buttons/frame_button_green.png"
const ASSET_BUTTON_HOLD := "res://assets/ui/buttons/frame_button_yellow.png"
const ASSET_BUTTON_REJECT := "res://assets/ui/buttons/frame_button_red.png"
const ASSET_TOOL_SLOT := "res://assets/ui/buttons/frame_tool_slot.png"
const ASSET_SCANNER_DEVICE := "res://assets/ui/props/prop_scanner_device.png"
const ASSET_STAMP_PROP := "res://assets/ui/props/prop_physical_stamp.png"
const ASSET_RULEBOOK_PROP := "res://assets/ui/props/prop_rulebook_closed.png"

@onready var day_label: Label = $StatusBar/StatusDayPanel/DayValue
@onready var _status_credits_panel: PanelContainer = $StatusBar/StatusCreditsPanel
@onready var credits_label: Label = $StatusBar/StatusCreditsPanel/CreditsHBox/CreditsValue
@onready var _suspicion_bar: ProgressBar = $StatusBar/StatusSuspicionPanel/SuspicionHBox/SuspicionValueBox/SuspicionValueBar
@onready var _alert_icon: Label = $StatusBar/StatusSuspicionPanel/SuspicionHBox/AlertSlot/AlertValue
@onready var _overlay_panel: PanelContainer = $OverlayLayer/OverlayPanel
@onready var _overlay_blocker: ColorRect = $OverlayLayer/OverlayBlocker
@onready var _overlay_title: Label = $OverlayLayer/OverlayPanel/OverlayVBox/OverlayTitleBar/OverlayTitle
@onready var _overlay_content: Label = $OverlayLayer/OverlayPanel/OverlayVBox/OverlayScroll/OverlayContent
@onready var _overlay_close_btn: Button = $OverlayLayer/OverlayPanel/OverlayVBox/OverlayTitleBar/OverlayCloseBtn
@onready var panel_title: Label = $DossierPanel/DocumentView/ScrollContainer/ContentVBox/IdentityContent/ApplicantVBox/PanelTitle
@onready var applicant_origin: Label = $DossierPanel/DocumentView/ScrollContainer/ContentVBox/IdentityContent/ApplicantVBox/ApplicantOrigin
@onready var applicant_destination: Label = $DossierPanel/DocumentView/ScrollContainer/ContentVBox/IdentityContent/ApplicantVBox/ApplicantDestination
@onready var applicant_purpose: Label = $DossierPanel/DocumentView/ScrollContainer/ContentVBox/IdentityContent/ApplicantVBox/ApplicantPurpose
@onready var dialogue_text: Label = $DialogueArea/DialogueBox/DialogueVBox/DialogueText
@onready var _question_buttons_area: VBoxContainer = $DialogueArea/QuestionButtonsArea
@onready var doc_content: Label = $DossierPanel/DocumentView/ScrollContainer/ContentVBox/DocContent
@onready var alerts_list: Label = $DossierPanel/AlertsStore/ScrollAlertas/AlertsList
@onready var _tab_alertas: Button = $DossierPanel/DocTabs/TabAlertas
@onready var _alerts_store: VBoxContainer = $DossierPanel/AlertsStore
@onready var _regs_store: VBoxContainer = $DossierPanel/RegsStore
@onready var approve_btn: Button = $DecisionBar/DecisionHBox/ApproveButton
@onready var hold_btn: Button = $DecisionBar/DecisionHBox/HoldButton
@onready var reject_btn: Button = $DecisionBar/DecisionHBox/RejectButton
@onready var scanner_btn: Button = $ConsoleArea/ScannerButton
@onready var _document_scanner_btn: Button = $ConsoleArea/DocumentScannerButton
@onready var _stamp_btn: Button = $ConsoleArea/StampButton
@onready var _regs_btn: Button = $ConsoleArea/RegsButton
@onready var _tool_scanner_btn: Button = $ToolsBar/ToolsBarHBox/ToolScanner
@onready var _tool_uv_btn: Button = $ToolsBar/ToolsBarHBox/ToolUV
@onready var _tool_verifier_btn: Button = $ToolsBar/ToolsBarHBox/ToolVerifier
@onready var _tool_stamp_btn: Button = $ToolsBar/ToolsBarHBox/ToolStamp
@onready var _tool_alert_btn: Button = $ToolsBar/ToolsBarHBox/ToolAlert
@onready var _tool_registry_btn: Button = $ToolsBar/ToolsBarHBox/ToolRegistry
@onready var _viewport_video: VideoStreamPlayer = $DialogueArea/ViewportVideo
@onready var tab1: Button = $DossierPanel/DocTabs/Tab1
@onready var tab2: Button = $DossierPanel/DocTabs/Tab2
@onready var tab3: Button = $DossierPanel/DocTabs/Tab3
@onready var tab4: Button = $DossierPanel/DocTabs/Tab4
@onready var tab5: Button = $DossierPanel/DocTabs/Tab5
@onready var _tab_solicitante: Button = $DossierPanel/DocTabs/TabSolicitante
@onready var _identity_content: HBoxContainer = $DossierPanel/DocumentView/ScrollContainer/ContentVBox/IdentityContent
@onready var applicant_vbox: VBoxContainer = $DossierPanel/DocumentView/ScrollContainer/ContentVBox/IdentityContent/ApplicantVBox
@onready var _document_view: PanelContainer = $DossierPanel/DocumentView
@onready var _portrait_area: Control = $DossierPanel/DocumentView/ScrollContainer/ContentVBox/IdentityContent/PortraitArea
@onready var _panel_status:    Control = $StatusBar
@onready var _panel_dossier:   Control = $DossierPanel
@onready var _panel_dialogue:  Control = $DialogueArea
@onready var _panel_console:   Control = $ConsoleArea
@onready var _panel_decisions: PanelContainer = $DecisionBar

var current_day: int = 1
var current_date: String = "---"
var credits: int = 50
var day_data: Dictionary = {}
var applicants: Array = []
var documents: Dictionary = {}
var rules: Array = []
var queue: ApplicantQueue
var decision_system: DecisionSystem
var _applicant_docs: Dictionary = {}
var _scanner_used: bool = false
var _active_tab_index: int = 0
var _questions_container: VBoxContainer
var _audio: AudioStreamPlayer

# --- Estado interno para debug ---
var _current_applicant: Dictionary = {}
var _last_violations: Array = []
var _last_decision_result: Dictionary = {}
var _debug_panel: PanelContainer
var _debug_label: Label

func _ready() -> void:
	_apply_theme()
	_setup_tools_tabs()
	tab4.disabled = true
	tab5.disabled = true
	approve_btn.text = "APROBAR"
	reject_btn.text  = "RECHAZAR"
	hold_btn.text    = "INSPECC."
	hold_btn.tooltip_text = "Usar cuando el expediente requiera verificacion adicional, custodia temporal o revision superior."
	hold_btn.add_theme_font_size_override("font_size", 13)
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
	current_date = day_data.get("current_date", "---")
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
	panel_title.text = applicant.get("name", "---")
	_update_status_bar()
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
	applicant_origin.text = "Procesados: %d / %d" % [total, applicants.size()]
	applicant_destination.text = ""
	applicant_purpose.text = ""
	dialogue_text.text = "El turno ha concluido.\nGenerando reporte..."
	doc_content.text = "[ Sin caso activo ]"
	alerts_list.text = "---"
	_set_decision_buttons_enabled(false)
	_set_question_buttons_disabled(_questions_container, true)
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
	_style_panel(_panel_status,    Color(0.02, 0.04, 0.02, 0.75), COLOR_BORDER)
	_style_panel(_panel_dossier,   Color(0, 0, 0, 0), Color(0, 0, 0, 0))
	_style_panel(_panel_dialogue,  Color(0, 0, 0, 0), Color(0, 0, 0, 0))
	_style_panel(_panel_console,   Color(0, 0, 0, 0), Color(0, 0, 0, 0))
	_style_panel(_panel_decisions, Color(0, 0, 0, 0), Color(0, 0, 0, 0))
	_style_document_view(false)
	_style_button(approve_btn, COLOR_APPROVE, ASSET_BUTTON_APPROVE)
	_style_button(hold_btn, COLOR_HOLD, ASSET_BUTTON_HOLD)
	_style_button(reject_btn, COLOR_REJECT, ASSET_BUTTON_REJECT)
	_style_button(scanner_btn, Color.WHITE, ASSET_SCANNER_DEVICE)
	_style_button(_document_scanner_btn, COLOR_TOOL, ASSET_DOCUMENT_SCANNER_FRAME)
	_style_button(_stamp_btn, Color.WHITE, ASSET_STAMP_PROP)
	_style_button(_regs_btn, Color.WHITE, ASSET_RULEBOOK_PROP)
	_style_button(_overlay_close_btn, COLOR_REJECT)
	for tool_btn in [_tool_scanner_btn, _tool_uv_btn, _tool_verifier_btn, _tool_stamp_btn, _tool_alert_btn, _tool_registry_btn]:
		_style_button(tool_btn, COLOR_TOOL, ASSET_TOOL_SLOT)
	_apply_labels_color(self)
	_style_tab_buttons()
	if _viewport_video != null:
		_viewport_video.finished.connect(_on_viewport_video_finished)

func _style_panel(panel: Control, bg: Color, border: Color, texture_path: String = "") -> void:
	if panel is PanelContainer:
		var textured := _make_texture_style(texture_path, 8, 8)
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
	var s_focus: StyleBox = _make_button_style(texture_path, color.lightened(0.25))
	btn.add_theme_stylebox_override("focus", s_focus)
	btn.add_theme_color_override("font_pressed_color", Color(1.0, 1.0, 1.0, 1))
	btn.add_theme_color_override("font_focus_color", Color(1.0, 1.0, 1.0, 1))

func _make_texture_style(path: String, content_margin: int, texture_margin: int) -> StyleBoxTexture:
	if path == "":
		return null
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

func _style_button_selected(btn: Button, color: Color) -> void:
	var s := StyleBoxFlat.new()
	s.bg_color = color.lightened(0.12)
	s.border_color = Color(0.15, 0.45, 0.15, 1)
	s.set_border_width_all(1)
	s.set_content_margin_all(6)
	btn.add_theme_stylebox_override("normal", s)
	btn.add_theme_color_override("font_color", Color(1.0, 1.0, 1.0, 1))

func _style_button_error(btn: Button) -> void:
	var s := StyleBoxFlat.new()
	s.bg_color = Color(0.45, 0.04, 0.04, 1)
	s.border_color = Color(1.0, 0.2, 0.2, 1)
	s.set_border_width_all(2)
	s.set_content_margin_all(8)
	btn.add_theme_stylebox_override("normal", s)
	btn.add_theme_color_override("font_color", Color(1.0, 0.5, 0.5, 1))

func _style_document_view(scanner_mode: bool) -> void:
	var texture_path := ASSET_DOCUMENT_SCANNER_FRAME if scanner_mode else ""
	_style_panel(_document_view, COLOR_PANEL_DARK, COLOR_BORDER, texture_path)

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
	_document_scanner_btn.pressed.connect(_on_scanner_pressed)
	_tool_scanner_btn.pressed.connect(_on_scanner_pressed)
	_stamp_btn.pressed.connect(func(): _show_overlay("SELLO FISICO", "Sello disponible para marcar documentos cuando el flujo de documentos fisicos este activo."))
	_tool_stamp_btn.pressed.connect(func(): _show_overlay("HERRAMIENTA SELLO", "Alterna entre sellos de aprobado, observado y rechazado en la version final."))
	_tool_uv_btn.pressed.connect(func(): _show_overlay("LUZ UV", "Herramienta reservada para inspeccionar marcas invisibles en documentos."))
	_tool_verifier_btn.pressed.connect(func(): _show_overlay("VERIFICADOR", "Herramienta reservada para comparar datos cruzados del expediente."))
	_tool_alert_btn.pressed.connect(func(): _show_overlay("ALERTA", "Herramienta reservada para marcar sospecha o llamar seguridad."))
	_tool_registry_btn.pressed.connect(func(): _show_overlay("REGISTRO", "Bitacora del turno y casos procesados."))
	_status_credits_panel.gui_input.connect(_on_credits_panel_gui_input)
	_tab_solicitante.pressed.connect(_show_tab_solicitante)
	tab1.pressed.connect(func(): _show_doc_by_type("transit_pass", tab1))
	tab2.pressed.connect(func(): _show_doc_by_type("bio_cert", tab2))
	tab3.pressed.connect(func(): _show_doc_by_type("ingress_permit", tab3))
	tab4.pressed.connect(func(): _show_doc_by_type("salvoconducto", tab4))
	tab5.pressed.connect(func(): _show_doc_by_type("orden_superior", tab5))
	_tab_alertas.pressed.connect(_show_tab_alertas)
	_overlay_close_btn.pressed.connect(_close_overlay)
	_regs_btn.pressed.connect(func(): _show_tools_tab("regs"))

func _on_viewport_video_finished() -> void:
	if _viewport_video == null:
		return
	_viewport_video.play()

func _input(event: InputEvent) -> void:
	if not (event is InputEventKey and event.pressed and not event.echo):
		return
	if _overlay_panel.visible:
		if event.keycode == KEY_ESCAPE:
			_close_overlay()
		get_viewport().set_input_as_handled()
		return
	var handled := true
	match event.keycode:
		KEY_Y:
			_toggle_debug_panel()
		KEY_A:
			if not approve_btn.disabled: _on_approve_pressed()
		KEY_S:
			if not hold_btn.disabled:    _on_hold_pressed()
		KEY_D:
			if not reject_btn.disabled:  _on_reject_pressed()
		KEY_E:
			if not scanner_btn.disabled: _on_scanner_pressed()
		KEY_W:
			_cycle_doc_tab()
		KEY_Q:
			_press_next_question()
		_:
			handled = false
	if handled:
		get_viewport().set_input_as_handled()

func _on_credits_panel_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		var mouse_event := event as InputEventMouseButton
		if mouse_event.pressed and mouse_event.button_index == MOUSE_BUTTON_LEFT:
			_toggle_debug_panel()
			get_viewport().set_input_as_handled()
	elif event is InputEventScreenTouch and event.pressed:
		_toggle_debug_panel()
		get_viewport().set_input_as_handled()

func _toggle_debug_panel() -> void:
	_debug_panel.visible = not _debug_panel.visible
	if _debug_panel.visible and not _current_applicant.is_empty():
		_update_debug_panel(_current_applicant)

func _update_status_bar() -> void:
	var pos := queue.get_current_index() + 1 if queue != null else 0
	var total := queue.get_total() if queue != null else 0
	day_label.text = "DIA %d\n%s\n%d / %d" % [current_day, current_date, pos, total]
	credits_label.text = "CREDITOS\n%d" % credits
	var acc := NarrativeStateSystem.get_accumulators()
	var suspicion: float = acc.get("suspicion", 0.0)
	_suspicion_bar.value = clamp(suspicion, 0.0, 100.0)
	var has_alerts := alerts_list.text != "Sin irregularidades." and alerts_list.text != "--- Sin alertas ---"
	_alert_icon.modulate = Color(1.0, 0.2, 0.2, 1) if has_alerts else Color(0.2, 0.6, 0.2, 1)

func _reset_applicant_panel() -> void:
	panel_title.text = "SOLICITANTE"
	applicant_origin.text = "Origen: ---"
	applicant_destination.text = "Destino: ---"
	applicant_purpose.text = "Motivo: ---"
	dialogue_text.text = "Cargando turno..."
	doc_content.text = "[ Sin documento activo ]"
	alerts_list.text = "--- Sin alertas ---"
	_identity_content.visible = true
	_portrait_area.visible = true
	applicant_vbox.visible = true
	doc_content.visible = false
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
	_identity_content.visible = false
	_portrait_area.visible = false
	applicant_vbox.visible = false
	doc_content.visible = true
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
	_document_scanner_btn.disabled = true
	_tool_scanner_btn.disabled = true
	scanner_btn.text = "ESCANER"
	_tool_scanner_btn.text = "ESC\n0"
	SoundManager.play_scan(_audio)
	await get_tree().create_timer(0.4).timeout
	_show_scan_results()
	scanner_btn.text = "ESCANER"

func _show_scan_results() -> void:
	var applicant := queue.get_current()
	var flags: Array = applicant.get("flags", [])
	var risk: String = applicant.get("truth", {}).get("risk_level", "low")

	var lines: Array = [
		"INFORME DE ESCANER — UMBRAL 7",
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
	_show_overlay("INFORME ESCANER", "\n".join(lines))

	var rule_alerts: String = alerts_list.text
	var scanner_block: String = "\n".join(alert_texts)
	if rule_alerts in ["Sin irregularidades.", "--- Sin alertas ---"]:
		alerts_list.text = scanner_block
	else:
		alerts_list.text = rule_alerts + "\n---\n" + scanner_block
	if _active_tab_index == 6:
		_render_alertas()

	print("[Escaner] %s — Flags: %s" % [applicant.get("name", "?"), str(flags)])

func _reset_scanner() -> void:
	_scanner_used = false
	scanner_btn.text = "ESCANER"
	_document_scanner_btn.text = ""
	_tool_scanner_btn.text = "ESC\n3"
	scanner_btn.disabled = false
	_document_scanner_btn.disabled = false
	_tool_scanner_btn.disabled = false

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
	var violations := RuleEngine.evaluate(_applicant_docs, rules, current_date)
	_last_violations = violations
	if violations.is_empty():
		alerts_list.text = "Sin irregularidades."
		if _active_tab_index == 6:
			_render_alertas()
		return
	var lines: Array = []
	for v in violations:
		lines.append("! " + v.get("description", "Violacion"))
		if v.get("detail", "") != "":
			lines.append("  " + v["detail"])
	alerts_list.text = "\n".join(lines)
	if _active_tab_index == 6:
		_render_alertas()
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
	tab3.disabled = not _applicant_docs.has("ingress_permit")
	tab4.disabled = not _applicant_docs.has("salvoconducto")
	tab5.disabled = not _applicant_docs.has("orden_superior")
	_show_tab_solicitante()


func _show_tab_solicitante() -> void:
	_document_view.visible = true
	_identity_content.visible = true
	_portrait_area.visible = true
	_alerts_store.visible = false
	_regs_store.visible = false
	applicant_vbox.visible = true
	doc_content.visible = false
	_set_active_tab(_tab_solicitante)

func _show_doc_by_type(dtype: String, active_btn: Button) -> void:
	if not _applicant_docs.has(dtype):
		return
	_document_view.visible = true
	_identity_content.visible = false
	_portrait_area.visible = false
	_alerts_store.visible = false
	_regs_store.visible = false
	applicant_vbox.visible = false
	doc_content.visible = true
	_style_document_view(false)
	_set_active_tab(active_btn)
	_render_document(_applicant_docs[dtype])

func _show_tab_alertas() -> void:
	_document_view.visible = true
	_identity_content.visible = false
	_portrait_area.visible = false
	_alerts_store.visible = false
	_regs_store.visible = false
	applicant_vbox.visible = false
	doc_content.visible = true
	_style_document_view(false)
	_set_active_tab(_tab_alertas)
	_render_alertas()


func _set_active_tab(active_btn: Button) -> void:
	var tabs := [_tab_solicitante, tab1, tab2, tab3, tab4, tab5, _tab_alertas]
	for i in tabs.size():
		if tabs[i] == active_btn:
			_active_tab_index = i
			break
	_style_tab_buttons()
	_style_button_selected(active_btn, Color(0.10, 0.22, 0.10, 1))

func _render_document(doc: Dictionary) -> void:
	var label: String = doc.get("label", "DOCUMENTO")
	var fields: Dictionary = doc.get("fields", {})
	var lines: Array = [label.to_upper(), ""]
	for key in fields:
		var k: String = str(key).replace("_", " ").to_upper()
		lines.append("%s: %s" % [k, str(fields[key])])
	doc_content.text = "\n".join(lines)

func _render_alertas() -> void:
	var alert_text := alerts_list.text.strip_edges()
	if alert_text == "" or alert_text in ["Sin irregularidades.", "--- Sin alertas ---"]:
		doc_content.text = "ALERTAS\n\nSin irregularidades."
		return
	doc_content.text = "ALERTAS\n\n" + alert_text

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
	_panel_decisions.modulate = flash
	var tween := create_tween()
	tween.tween_property(_panel_decisions, "modulate", Color.WHITE, 0.35)

func _flash_credits_label() -> void:
	credits_label.add_theme_color_override("font_color", Color.WHITE)
	var tween := create_tween()
	tween.tween_interval(0.2)
	tween.tween_callback(func(): credits_label.add_theme_color_override("font_color", COLOR_TEXT))

# --- Sistema de preguntas ---

func _setup_questions_area() -> void:
	_questions_container = VBoxContainer.new()
	_questions_container.add_theme_constant_override("separation", 4)
	_questions_container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_question_buttons_area.add_child(_questions_container)

func _reset_questions(applicant: Dictionary) -> void:
	for child in _questions_container.get_children():
		_questions_container.remove_child(child)
		child.free()

	var questions: Dictionary = applicant.get("questions", {})
	var question_alerts: Dictionary = applicant.get("question_alerts", {})
	var question_labels := {
		"motivo":    "MOTIVO",
		"origen":    "ORIGEN",
		"carga":     "CARGA",
		"identidad": "IDENTIDAD",
		"historial": "HISTORIAL"
	}
	var columns := [
		["motivo", "origen", "carga"],
		["identidad", "historial"]
	]
	var grid := HBoxContainer.new()
	grid.add_theme_constant_override("separation", 4)
	grid.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	for column_keys in columns:
		var column := VBoxContainer.new()
		column.add_theme_constant_override("separation", 4)
		column.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		for key in column_keys:
			var btn := _create_question_button(key, question_labels[key], questions, question_alerts)
			column.add_child(btn)
		grid.add_child(column)
	_questions_container.add_child(grid)

func _create_question_button(key: String, label: String, questions: Dictionary, question_alerts: Dictionary) -> Button:
	var btn := Button.new()
	btn.text = label
	btn.alignment = HORIZONTAL_ALIGNMENT_CENTER
	btn.custom_minimum_size = Vector2(0, 20)
	btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_style_question_button(btn)
	if questions.has(key):
		var response: String = questions[key]
		var alert: String = question_alerts.get(key, "")
		btn.pressed.connect(_on_question_asked.bind(key, response, alert, btn))
	else:
		btn.disabled = true
	return btn

func _style_question_button(btn: Button) -> void:
	var s_normal := StyleBoxFlat.new()
	s_normal.bg_color = COLOR_QUESTION
	s_normal.border_color = COLOR_TEXT_DIM
	s_normal.set_border_width_all(1)
	s_normal.set_content_margin_all(4)
	var s_hover := StyleBoxFlat.new()
	s_hover.bg_color = COLOR_QUESTION.lightened(0.15)
	s_hover.border_color = COLOR_TEXT
	s_hover.set_border_width_all(1)
	s_hover.set_content_margin_all(4)
	var s_disabled := StyleBoxFlat.new()
	s_disabled.bg_color = COLOR_QUESTION.darkened(0.4)
	s_disabled.border_color = COLOR_QUESTION.darkened(0.2)
	s_disabled.set_border_width_all(1)
	s_disabled.set_content_margin_all(4)
	btn.add_theme_stylebox_override("normal", s_normal)
	btn.add_theme_stylebox_override("hover", s_hover)
	btn.add_theme_stylebox_override("disabled", s_disabled)
	btn.add_theme_color_override("font_color", COLOR_TEXT)
	btn.add_theme_color_override("font_hover_color", Color(1.0, 1.0, 1.0, 1))
	btn.add_theme_color_override("font_disabled_color", COLOR_TEXT_DIM)
	btn.add_theme_font_size_override("font_size", 8)

func _cycle_doc_tab() -> void:
	var tabs := [_tab_solicitante, tab1, tab2, tab3, tab4, tab5, _tab_alertas]
	var next_start := (_active_tab_index + 1) % tabs.size()
	for i in tabs.size():
		var idx := (next_start + i) % tabs.size()
		if not tabs[idx].disabled:
			tabs[idx].pressed.emit()
			return

func _press_next_question() -> void:
	var btn := _find_next_enabled_question(_questions_container)
	if btn != null:
		btn.pressed.emit()

func _set_question_buttons_disabled(node: Node, disabled: bool) -> void:
	for child in node.get_children():
		if child is Button:
			child.disabled = disabled
		else:
			_set_question_buttons_disabled(child, disabled)

func _find_next_enabled_question(node: Node) -> Button:
	for child in node.get_children():
		if child is Button and not child.disabled:
			return child
		var nested := _find_next_enabled_question(child)
		if nested != null:
			return nested
	return null

func _on_question_asked(key: String, response: String, alert: String, btn: Button) -> void:
	dialogue_text.text = response
	btn.disabled = true
	if alert != "":
		var current_alerts: String = alerts_list.text
		if current_alerts in ["Sin irregularidades.", "--- Sin alertas ---"]:
			alerts_list.text = alert
		else:
			alerts_list.text = current_alerts + "\n" + alert
		if _active_tab_index == 6:
			_render_alertas()
		SoundManager.play_alert(_audio)
		print("[Pregunta] ALERTA — %s: %s" % [key, alert])

# --- Panel de debug interno (solo desarrollo) ---

func _build_debug_panel() -> void:
	_debug_panel = PanelContainer.new()
	_debug_panel.visible = false
	_debug_panel.z_index = 100
	_debug_panel.mouse_filter = Control.MOUSE_FILTER_STOP
	# Posición: cubre el lado izquierdo (sobre el panel de solicitante)
	_debug_panel.set_anchor_and_offset(SIDE_LEFT,   0.0,  4)
	_debug_panel.set_anchor_and_offset(SIDE_RIGHT,  1.0, -4)
	_debug_panel.set_anchor_and_offset(SIDE_TOP,    0.0,  4)
	_debug_panel.set_anchor_and_offset(SIDE_BOTTOM, 1.0, -4)

	var style := StyleBoxFlat.new()
	style.bg_color = Color(0.02, 0.04, 0.12, 0.93)
	style.border_color = Color(0.20, 0.60, 0.90, 1)
	style.set_border_width_all(2)
	style.set_content_margin_all(8)
	_debug_panel.add_theme_stylebox_override("panel", style)

	var vbox := VBoxContainer.new()
	vbox.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	vbox.size_flags_vertical = Control.SIZE_EXPAND_FILL

	var title := Label.new()
	title.text = "[ DEBUG — SOLO DESARROLLO ]  Y: ocultar"
	title.add_theme_font_size_override("font_size", 9)
	title.add_theme_color_override("font_color", Color(1.0, 0.75, 0.15, 1))
	title.mouse_filter = Control.MOUSE_FILTER_IGNORE

	# --- Navegacion rapida por dia ---
	var nav_label := Label.new()
	nav_label.text = "IR A DIA:"
	nav_label.add_theme_font_size_override("font_size", 9)
	nav_label.add_theme_color_override("font_color", Color(1.0, 0.75, 0.15, 1))
	nav_label.mouse_filter = Control.MOUSE_FILTER_IGNORE

	var nav_grid := GridContainer.new()
	nav_grid.columns = 3
	nav_grid.add_theme_constant_override("h_separation", 4)
	nav_grid.add_theme_constant_override("v_separation", 4)
	for d in range(1, 10):
		var day_path := "res://data/days/day_%02d.json" % d
		if not FileAccess.file_exists(day_path):
			break
		var day_btn := Button.new()
		day_btn.text = "DIA %d" % d
		day_btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		day_btn.add_theme_font_size_override("font_size", 9)
		var s_nav := StyleBoxFlat.new()
		s_nav.bg_color = Color(0.10, 0.06, 0.22, 1)
		s_nav.border_color = Color(0.55, 0.35, 0.90, 1)
		s_nav.set_border_width_all(1)
		s_nav.set_content_margin_all(3)
		var s_nav_h := StyleBoxFlat.new()
		s_nav_h.bg_color = Color(0.18, 0.10, 0.38, 1)
		s_nav_h.border_color = Color(0.75, 0.55, 1.0, 1)
		s_nav_h.set_border_width_all(1)
		s_nav_h.set_content_margin_all(3)
		day_btn.add_theme_stylebox_override("normal", s_nav)
		day_btn.add_theme_stylebox_override("hover",  s_nav_h)
		day_btn.add_theme_color_override("font_color", Color(0.85, 0.70, 1.0, 1))
		day_btn.pressed.connect(_jump_to_day.bind(d))
		nav_grid.add_child(day_btn)

	var sep_nav := HSeparator.new()
	var sep := HSeparator.new()

	var scroll := ScrollContainer.new()
	scroll.size_flags_vertical = Control.SIZE_EXPAND_FILL
	scroll.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	scroll.horizontal_scroll_mode = ScrollContainer.SCROLL_MODE_DISABLED
	scroll.mouse_filter = Control.MOUSE_FILTER_STOP

	_debug_label = Label.new()
	_debug_label.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	_debug_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	_debug_label.add_theme_font_size_override("font_size", 9)
	_debug_label.add_theme_color_override("font_color", Color(0.55, 0.90, 1.0, 1))
	_debug_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_debug_label.text = "Sin caso activo."

	scroll.add_child(_debug_label)
	vbox.add_child(title)
	vbox.add_child(sep_nav)
	vbox.add_child(nav_label)
	vbox.add_child(nav_grid)
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
	pass

func _show_tools_tab(tab: String) -> void:
	if tab == "regs":
		var regs_lines: Array = []
		for child in _regs_store.get_children():
			if child is Label:
				regs_lines.append(child.text)
		_show_overlay("REGLAMENTO ACTIVO", "\n\n".join(regs_lines))
		return


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
		_regs_store.add_child(lbl)

func _show_overlay(title: String, content: String) -> void:
	_overlay_title.text = title
	_overlay_content.text = content
	_overlay_blocker.visible = true
	_overlay_panel.visible = true

func _close_overlay() -> void:
	_overlay_panel.visible = false
	_overlay_blocker.visible = false

func _style_tab_buttons() -> void:
	for tab in [_tab_solicitante, tab1, tab2, tab3, tab4, tab5, _tab_alertas]:
		var s := StyleBoxFlat.new()
		s.bg_color = Color(0.05, 0.10, 0.05, 1)
		s.border_color = COLOR_BORDER
		s.set_border_width_all(1)
		s.set_content_margin_all(2)
		var s_hover := StyleBoxFlat.new()
		s_hover.bg_color = Color(0.08, 0.16, 0.08, 1)
		s_hover.border_color = COLOR_TEXT
		s_hover.set_border_width_all(1)
		s_hover.set_content_margin_all(2)
		var s_disabled := StyleBoxFlat.new()
		s_disabled.bg_color = Color(0.03, 0.05, 0.03, 1)
		s_disabled.border_color = Color(0.07, 0.12, 0.07, 1)
		s_disabled.set_border_width_all(1)
		s_disabled.set_content_margin_all(2)
		tab.add_theme_stylebox_override("normal", s)
		tab.add_theme_stylebox_override("hover", s_hover)
		tab.add_theme_stylebox_override("disabled", s_disabled)
		tab.add_theme_color_override("font_color", COLOR_TEXT_DIM)
		tab.add_theme_color_override("font_hover_color", COLOR_TEXT)
		tab.add_theme_color_override("font_disabled_color", Color(0.18, 0.28, 0.18, 1))
