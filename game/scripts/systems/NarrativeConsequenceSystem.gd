class_name NarrativeConsequenceSystem

static func evaluate(summary: Dictionary, day: int) -> Dictionary:
	var path := "res://data/consequences/consequences_day_%02d.json" % day
	if not FileAccess.file_exists(path):
		return _neutral()
	var file := FileAccess.open(path, FileAccess.READ)
	if file == null:
		return _neutral()
	var parsed = JSON.parse_string(file.get_as_text())
	file.close()
	if not parsed is Array:
		return _neutral()

	var candidates: Array = []
	for entry in parsed:
		if entry is Dictionary and _matches(entry, summary):
			candidates.append(entry)

	if candidates.is_empty():
		return _neutral()

	candidates.sort_custom(func(a, b): return a.get("priority", 0) > b.get("priority", 0))
	return candidates[0]

static func _matches(entry: Dictionary, summary: Dictionary) -> bool:
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

static func _neutral() -> Dictionary:
	return {
		"id": "neutral",
		"title": "Turno registrado.",
		"body": "El Ministerio de Admision Planetaria ha registrado el cierre del turno. Sin observaciones adicionales."
	}
