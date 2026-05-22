class_name DayReport
extends Control

static var pending_summary: Dictionary = {}

const COLOR_PANEL  := Color(0.06, 0.10, 0.06, 1)
const COLOR_BORDER := Color(0.15, 0.45, 0.15, 1)
const COLOR_TEXT   := Color(0.18, 0.82, 0.18, 1)
const COLOR_OK     := Color(0.18, 0.82, 0.18, 1)
const COLOR_ERROR  := Color(0.82, 0.22, 0.22, 1)
const COLOR_DIM    := Color(0.35, 0.55, 0.35, 1)
const COLOR_BTN    := Color(0.08, 0.36, 0.08, 1)

@onready var processed_label: Label   = $VBox/ScrollArea/ContentVBox/SummaryPanel/SummaryVBox/ProcessedLabel
@onready var correct_label: Label     = $VBox/ScrollArea/ContentVBox/SummaryPanel/SummaryVBox/CorrectLabel
@onready var errors_label: Label      = $VBox/ScrollArea/ContentVBox/SummaryPanel/SummaryVBox/ErrorsLabel
@onready var credits_label: Label     = $VBox/ScrollArea/ContentVBox/SummaryPanel/SummaryVBox/CreditsLabel
@onready var decisions_list: VBoxContainer = $VBox/ScrollArea/ContentVBox/DecisionsPanel/DecisionsVBox/DecisionsList
@onready var consequence_text: Label  = $VBox/ScrollArea/ContentVBox/ConsequencePanel/ConsequenceVBox/ConsequenceText
@onready var restart_btn: Button      = $VBox/Footer/FooterHBox/RestartBtn

func _ready() -> void:
	_apply_theme()
	_populate(pending_summary)
	restart_btn.pressed.connect(_on_restart_pressed)

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

	consequence_text.text = _get_consequence(errors, credits)

func _add_decision_row(decision: Dictionary) -> void:
	var was_correct: bool = decision.get("was_correct", false)
	var name: String      = decision.get("applicant_name", "?")
	var dec: String       = decision.get("decision", "?").to_upper()
	var delta: int        = decision.get("credit_delta", 0)

	var indicator := "[OK]" if was_correct else "[!] "
	var delta_str := ("  %d" % delta) if delta < 0 else ""

	var row := Label.new()
	row.text = "%s  %-22s %s%s" % [indicator, name, dec, delta_str]
	row.add_theme_color_override("font_color", COLOR_OK if was_correct else COLOR_ERROR)
	row.add_theme_font_size_override("font_size", 13)
	decisions_list.add_child(row)

func _get_consequence(errors: int, credits: int) -> String:
	if errors == 0:
		return "Turno sin incidentes.\n\nEl Ministerio de Admision registra eficiencia maxima en el Puesto Umbral 7. Su expediente se actualiza favorablemente."
	elif errors <= 2:
		return "Turno con irregularidades menores.\n\nSe emite notificacion interna. El Supervisor Halvek recomienda mayor atencion al protocolo en la proxima jornada."
	elif errors <= 5:
		return "Turno deficiente.\n\nEl Supervisor Halvek solicita revision formal de su expediente. Se aplica penalizacion de creditos en la proxima jornada. No cometa los mismos errores."
	else:
		return "Turno catastrofico.\n\nSe abre expediente disciplinario en el Oficio de Pureza Civica. Su continuidad en el Puesto Umbral 7 esta en revision. El Sello no perdona la negligencia."

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

func _on_restart_pressed() -> void:
	pending_summary = {}
	get_tree().change_scene_to_file("res://scenes/main/ControlDesk.tscn")
