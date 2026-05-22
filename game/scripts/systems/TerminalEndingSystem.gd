class_name TerminalEndingSystem

const PATH := "res://data/endings/terminal_endings.json"

static func evaluate(summary: Dictionary) -> Dictionary:
	if not FileAccess.file_exists(PATH):
		return {}
	var file := FileAccess.open(PATH, FileAccess.READ)
	if file == null:
		return {}
	var parsed = JSON.parse_string(file.get_as_text())
	file.close()
	if not parsed is Array:
		return {}

	var acc := NarrativeStateSystem.get_accumulators()
	var day: int = summary.get("day", 1)
	var candidates: Array = []
	for entry in parsed:
		if entry is Dictionary and _matches(entry, acc, day):
			candidates.append(entry)

	if candidates.is_empty():
		return {}

	candidates.sort_custom(func(a, b): return a.get("priority", 0) > b.get("priority", 0))
	var winner: Dictionary = candidates[0]
	print("[TerminalEnding] Activado: %s (prioridad: %d)" % [winner.get("id", "?"), winner.get("priority", 0)])
	return winner

static func _matches(entry: Dictionary, acc: Dictionary, day: int) -> bool:
	var cond: Dictionary = entry.get("conditions", {})
	if cond.has("min_day") and day < int(cond["min_day"]):
		return false
	if cond.has("institutional_trust_max") and acc.get("institutional_trust", 0) > int(cond["institutional_trust_max"]):
		return false
	if cond.has("institutional_trust_min") and acc.get("institutional_trust", 0) < int(cond["institutional_trust_min"]):
		return false
	if cond.has("security_risk_min") and acc.get("security_risk", 0) < int(cond["security_risk_min"]):
		return false
	if cond.has("supervisor_suspicion_min") and acc.get("supervisor_suspicion", 0) < int(cond["supervisor_suspicion_min"]):
		return false
	if cond.has("civilian_harm_min") and acc.get("civilian_harm", 0) < int(cond["civilian_harm_min"]):
		return false
	return true
