class_name DataLoader
extends RefCounted

static func load_day(day: int) -> Dictionary:
	return _load_json("res://data/days/day_%02d.json" % day)

static func load_applicants(day: int) -> Array:
	return _load_json("res://data/applicants/applicants_day_%02d.json" % day)

static func load_documents(day: int) -> Dictionary:
	var raw: Array = _load_json("res://data/documents/documents_day_%02d.json" % day)
	var map := {}
	for doc in raw:
		map[doc["id"]] = doc
	return map

static func load_rules(day: int) -> Array:
	return _load_json("res://data/rules/rules_day_%02d.json" % day)

static func _load_json(path: String) -> Variant:
	if not FileAccess.file_exists(path):
		push_error("[DataLoader] Archivo no encontrado: " + path)
		return []
	var file := FileAccess.open(path, FileAccess.READ)
	var json := JSON.new()
	var err := json.parse(file.get_as_text())
	file.close()
	if err != OK:
		push_error("[DataLoader] Error al parsear: " + path + " — linea " + str(json.get_error_line()))
		return []
	return json.get_data()
