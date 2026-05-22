extends Control

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

@onready var day_label: Label = $VBox/StatusBar/StatusHBox/DayLabel
@onready var credits_label: Label = $VBox/StatusBar/StatusHBox/CreditsLabel
@onready var panel_title: Label = $VBox/MainArea/ApplicantPanel/ApplicantVBox/PanelTitle
@onready var applicant_name: Label = $VBox/MainArea/ApplicantPanel/ApplicantVBox/ApplicantName
@onready var applicant_origin: Label = $VBox/MainArea/ApplicantPanel/ApplicantVBox/ApplicantOrigin
@onready var applicant_destination: Label = $VBox/MainArea/ApplicantPanel/ApplicantVBox/ApplicantDestination
@onready var applicant_purpose: Label = $VBox/MainArea/ApplicantPanel/ApplicantVBox/ApplicantPurpose
@onready var dialogue_text: Label = $VBox/MainArea/ApplicantPanel/ApplicantVBox/DialogueText
@onready var doc_content: Label = $VBox/MainArea/DocumentArea/DocumentVBox/DocumentView/DocContent
@onready var alerts_list: Label = $VBox/MainArea/ToolsPanel/ToolsVBox/AlertsList
@onready var approve_btn: Button = $VBox/DecisionBar/DecisionHBox/ApproveButton
@onready var hold_btn: Button = $VBox/DecisionBar/DecisionHBox/HoldButton
@onready var reject_btn: Button = $VBox/DecisionBar/DecisionHBox/RejectButton
@onready var scanner_btn: Button = $VBox/MainArea/ToolsPanel/ToolsVBox/ScannerButton
@onready var tab1: Button = $VBox/MainArea/DocumentArea/DocumentVBox/DocTabs/Tab1
@onready var tab2: Button = $VBox/MainArea/DocumentArea/DocumentVBox/DocTabs/Tab2
@onready var tab3: Button = $VBox/MainArea/DocumentArea/DocumentVBox/DocTabs/Tab3

var current_day: int = 1
var credits: int = 50
var day_data: Dictionary = {}
var applicants: Array = []
var documents: Dictionary = {}
var rules: Array = []
var queue: ApplicantQueue
var _applicant_docs: Dictionary = {}

func _ready() -> void:
	_apply_theme()
	_connect_signals()
	_update_status_bar()
	_reset_applicant_panel()
	_load_day_data()

func _load_day_data() -> void:
	day_data = DataLoader.load_day(current_day)
	applicants = DataLoader.load_applicants(current_day)
	documents = DataLoader.load_documents(current_day)
	rules = DataLoader.load_rules(current_day)
	print("[ControlDesk] Dia %d cargado — %d solicitantes, %d documentos, %d reglas" % [
		current_day, applicants.size(), documents.size(), rules.size()
	])
	queue = ApplicantQueue.new()
	add_child(queue)
	queue.applicant_changed.connect(_on_applicant_changed)
	queue.day_ended.connect(_on_day_ended)
	queue.load_applicants(applicants)
	queue.start()

func _on_applicant_changed(applicant: Dictionary) -> void:
	var pos := queue.get_current_index() + 1
	var total := queue.get_total()
	panel_title.text = "SOLICITANTE %d / %d" % [pos, total]
	applicant_name.text = applicant.get("name", "---")
	applicant_origin.text = "Origen: " + applicant.get("origin", "---")
	applicant_destination.text = "Destino: " + applicant.get("destination", "---")
	applicant_purpose.text = "Motivo: " + applicant.get("purpose", "---")
	dialogue_text.text = applicant.get("dialogue_intro", "---")
	alerts_list.text = "--- Sin alertas ---"
	_set_decision_buttons_enabled(true)
	_load_applicant_documents(applicant)

func _on_day_ended(total: int) -> void:
	panel_title.text = "TURNO CERRADO"
	applicant_name.text = "--- FIN DEL TURNO ---"
	applicant_origin.text = "Procesados: %d / %d" % [total, applicants.size()]
	applicant_destination.text = ""
	applicant_purpose.text = ""
	dialogue_text.text = "El turno ha concluido.\nEspere el reporte del dia."
	doc_content.text = "[ Sin caso activo ]"
	alerts_list.text = "---"
	_set_decision_buttons_enabled(false)
	print("[ControlDesk] Turno terminado — %d / %d procesados" % [total, applicants.size()])

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
	_style_panel($VBox/MainArea/DocumentArea/DocumentVBox/DocumentView, COLOR_PANEL_DARK, COLOR_BORDER)
	_style_button(approve_btn, COLOR_APPROVE)
	_style_button(hold_btn, COLOR_HOLD)
	_style_button(reject_btn, COLOR_REJECT)
	_style_button(scanner_btn, COLOR_TOOL)
	_apply_labels_color(self)
	_style_tab_buttons()

func _style_panel(panel: PanelContainer, bg: Color, border: Color) -> void:
	var style := StyleBoxFlat.new()
	style.bg_color = bg
	style.border_color = border
	style.set_border_width_all(1)
	style.set_content_margin_all(8)
	panel.add_theme_stylebox_override("panel", style)

func _style_button(btn: Button, color: Color) -> void:
	var s_normal := StyleBoxFlat.new()
	s_normal.bg_color = color
	s_normal.border_color = color.lightened(0.3)
	s_normal.set_border_width_all(1)
	s_normal.set_content_margin_all(8)

	var s_hover := StyleBoxFlat.new()
	s_hover.bg_color = color.lightened(0.2)
	s_hover.border_color = color.lightened(0.5)
	s_hover.set_border_width_all(1)
	s_hover.set_content_margin_all(8)

	var s_pressed := StyleBoxFlat.new()
	s_pressed.bg_color = color.darkened(0.2)
	s_pressed.border_color = color.lightened(0.3)
	s_pressed.set_border_width_all(1)
	s_pressed.set_content_margin_all(8)

	var s_disabled := StyleBoxFlat.new()
	s_disabled.bg_color = color.darkened(0.5)
	s_disabled.border_color = color.darkened(0.3)
	s_disabled.set_border_width_all(1)
	s_disabled.set_content_margin_all(8)

	btn.add_theme_stylebox_override("normal", s_normal)
	btn.add_theme_stylebox_override("hover", s_hover)
	btn.add_theme_stylebox_override("pressed", s_pressed)
	btn.add_theme_stylebox_override("disabled", s_disabled)
	btn.add_theme_color_override("font_color", Color(0.9, 0.95, 0.9, 1))
	btn.add_theme_color_override("font_hover_color", Color(1.0, 1.0, 1.0, 1))
	btn.add_theme_color_override("font_disabled_color", Color(0.4, 0.45, 0.4, 1))

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
	tab3.pressed.connect(func(): _show_doc_by_type("ingress_permit", tab3))

func _update_status_bar() -> void:
	day_label.text = "DIA %d" % current_day
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
	var name: String = queue.get_current().get("name", "?")
	print("[Decision] APROBAR — %s" % name)
	queue.advance()

func _on_hold_pressed() -> void:
	var name: String = queue.get_current().get("name", "?")
	print("[Decision] RETENER — %s" % name)
	queue.advance()

func _on_reject_pressed() -> void:
	var name: String = queue.get_current().get("name", "?")
	print("[Decision] RECHAZAR — %s" % name)
	queue.advance()

func _on_scanner_pressed() -> void:
	var applicant := queue.get_current()
	if applicant.is_empty():
		return
	var flags: Array = applicant.get("flags", [])
	if flags.has("biological_anomaly"):
		alerts_list.text = "ANOMALIA BIOLOGICA\nDETECTADA"
	elif flags.has("suspicious_dialogue"):
		alerts_list.text = "PATRON DE RESPUESTA\nIRREGULAR"
	elif flags.has("undeclared_device"):
		alerts_list.text = "OBJETO NO DECLARADO\nEN PERMISO"
	elif flags.has("cargo_mismatch"):
		alerts_list.text = "DISCREPANCIA EN\nDECLARACION DE CARGA"
	elif flags.has("missing_seal"):
		alerts_list.text = "SELLO DE AUTORIDAD\nAUSENTE"
	elif flags.has("expired_document"):
		alerts_list.text = "DOCUMENTO VENCIDO\nDETECTADO"
	else:
		alerts_list.text = "Sin anomalias."
	print("[Escaner] Flags: ", flags)

# --- Sistema de documentos ---

func _load_applicant_documents(applicant: Dictionary) -> void:
	_applicant_docs = {}
	for doc_id in applicant.get("documents", []):
		if documents.has(doc_id):
			var doc: Dictionary = documents[doc_id]
			_applicant_docs[doc.get("type", "")] = doc
	tab1.disabled = not _applicant_docs.has("transit_pass")
	tab2.disabled = not _applicant_docs.has("bio_cert")
	tab3.disabled = not _applicant_docs.has("ingress_permit")
	# Mostrar primer documento disponible
	if _applicant_docs.has("transit_pass"):
		_show_doc_by_type("transit_pass", tab1)
	elif _applicant_docs.has("bio_cert"):
		_show_doc_by_type("bio_cert", tab2)
	elif _applicant_docs.has("ingress_permit"):
		_show_doc_by_type("ingress_permit", tab3)
	else:
		doc_content.text = "[ Sin documentos ]"

func _show_doc_by_type(dtype: String, active_btn: Button) -> void:
	if not _applicant_docs.has(dtype):
		return
	_set_active_tab(active_btn)
	_render_document(_applicant_docs[dtype])

func _set_active_tab(active_btn: Button) -> void:
	for tab in [tab1, tab2, tab3]:
		var is_active := (tab == active_btn)
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
		var k := key.replace("_", " ").to_upper()
		lines.append("%s: %s" % [k, str(fields[key])])
	doc_content.text = "\n".join(lines)

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
