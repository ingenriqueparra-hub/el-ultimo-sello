class_name NarrativeStateSystem

static var _accumulators: Dictionary = {
	"institutional_trust": 0,
	"security_risk": 0,
	"civilian_harm": 0,
	"supervisor_suspicion": 0,
}
static var _snapshot: Dictionary = {}

static func snapshot() -> void:
	_snapshot = _accumulators.duplicate()

static func restore_snapshot() -> void:
	if not _snapshot.is_empty():
		_accumulators = _snapshot.duplicate()

static func apply_effects(effects: Dictionary) -> void:
	if effects.is_empty():
		return
	for key in effects:
		if _accumulators.has(key):
			_accumulators[key] += int(effects[key])
	print("[NarrativeState] Acumuladores: %s" % str(_accumulators))

static func get_accumulators() -> Dictionary:
	return _accumulators.duplicate()

static func reset() -> void:
	_accumulators = {
		"institutional_trust": 0,
		"security_risk": 0,
		"civilian_harm": 0,
		"supervisor_suspicion": 0,
	}
	_snapshot = {}

static func get_narrative_symptom() -> String:
	var parts: Array = []
	if _accumulators.get("security_risk", 0) >= 3:
		parts.append("Las alertas de seguridad en el Umbral se han intensificado.")
	if _accumulators.get("supervisor_suspicion", 0) >= 2:
		parts.append("El Supervisor Halvek ha solicitado revision adicional de su expediente.")
	if _accumulators.get("civilian_harm", 0) >= 2:
		parts.append("El Registro Civil documenta quejas sin respuesta sobre decisiones del turno.")
	if _accumulators.get("institutional_trust", 0) <= -2:
		parts.append("La confianza del Ministerio en el puesto de control ha disminuido.")
	return "\n".join(parts)
