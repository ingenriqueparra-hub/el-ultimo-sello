class_name NarrativeConsequenceSystem

static func evaluate(summary: Dictionary, day: int) -> Dictionary:
	var path := "res://data/consequences/consequences_day_%02d.json" % day
	if not FileAccess.file_exists(path):
		return _neutral_composite()
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		return _neutral_composite()
	var parsed = JSON.parse_string(file.get_as_text())
	file.close()
	if not parsed is Array:
		return _neutral_composite()

	var performance := _select_performance(parsed, summary)
	var incidents   := _select_incidents(parsed, summary)
	var synthesis   := _build_synthesis(performance, incidents)
	var effects     := _merge_effects(performance, incidents)
	NarrativeStateSystem.apply_effects(effects)

	print("[NarrativeConsequence] Performance: %s | Incidentes: %d | Sintesis: %s" % [
		performance.get("id", "neutral"), incidents.size(), synthesis != ""
	])

	return {
		"performance":     performance,
		"incidents":       incidents,
		"synthesis":       synthesis,
		"effects_applied": effects,
	}

static func _select_performance(parsed: Array, summary: Dictionary) -> Dictionary:
	var candidates: Array = []
	for entry in parsed:
		if entry is Dictionary and entry.get("type", "") == "performance":
			if _matches_conditions(entry, summary):
				candidates.append(entry)
	if candidates.is_empty():
		return _neutral_performance()
	candidates.sort_custom(func(a, b): return a.get("priority", 0) > b.get("priority", 0))
	return candidates[0]

static func _select_incidents(parsed: Array, summary: Dictionary) -> Array:
	var flags: Array = summary.get("activated_flags", [])
	var result: Array = []
	for entry in parsed:
		if entry is Dictionary and entry.get("type", "") == "case":
			var trigger: String = str(entry.get("trigger_flag", ""))
			if trigger != "" and trigger in flags:
				result.append(entry)
	result.sort_custom(func(a, b): return a.get("priority", 0) > b.get("priority", 0))
	return result

static func _matches_conditions(entry: Dictionary, summary: Dictionary) -> bool:
	var cond: Dictionary = entry.get("conditions", {})
	var errors: int  = summary.get("errors", 0)
	var credits: int = summary.get("credits", 0)
	var correct: int = summary.get("correct", 0)
	if cond.has("min_errors")  and errors  < int(cond["min_errors"]):  return false
	if cond.has("max_errors")  and errors  > int(cond["max_errors"]):  return false
	if cond.has("min_credits") and credits < int(cond["min_credits"]): return false
	if cond.has("max_credits") and credits > int(cond["max_credits"]): return false
	if cond.has("min_correct") and correct < int(cond["min_correct"]): return false
	return true

static func _build_synthesis(performance: Dictionary, incidents: Array) -> String:
	if incidents.is_empty():
		return ""
	var perf_tone: String = performance.get("tone", "neutral")
	var has_negative := false
	var has_positive := false
	var has_critical := false
	for inc in incidents:
		var t: String = inc.get("tone", "neutral")
		var s: String = inc.get("severity", "minor")
		if t == "negative" or t == "mixed":
			has_negative = true
			if s == "critical":
				has_critical = true
		if t == "positive":
			has_positive = true
	if perf_tone == "positive" or perf_tone == "neutral":
		if has_critical:
			return "El rendimiento general fue estable, pero un incidente critico compromete la evaluacion del puesto."
		elif has_negative and has_positive:
			return "El turno presenta acciones correctas e incidentes negativos. El Ministerio registra ambas notas en el expediente."
		elif has_negative:
			return "El rendimiento fue aceptable, pero los incidentes registrados requieren atencion en la siguiente jornada."
		else:
			return "El turno queda registrado como eficiente y con intervencion destacada."
	else:
		if has_positive:
			return "Aunque una accion correcta queda registrada, el patron general del turno revela negligencia operativa."
		else:
			return "Los incidentes registrados agravan un turno ya deficiente."

static func _merge_effects(performance: Dictionary, incidents: Array) -> Dictionary:
	var merged: Dictionary = {}
	for key in performance.get("effects", {}):
		merged[key] = int(performance["effects"][key])
	for inc in incidents:
		for key in inc.get("effects", {}):
			if merged.has(key):
				merged[key] += int(inc["effects"][key])
			else:
				merged[key] = int(inc["effects"][key])
	return merged

static func _neutral_composite() -> Dictionary:
	return {
		"performance":     _neutral_performance(),
		"incidents":       [],
		"synthesis":       "",
		"effects_applied": {},
	}

static func _neutral_performance() -> Dictionary:
	return {
		"id":    "neutral",
		"type":  "performance",
		"tone":  "neutral",
		"title": "Turno registrado.",
		"body":  "El Ministerio de Admision Planetaria ha registrado el cierre del turno. Sin observaciones adicionales."
	}
