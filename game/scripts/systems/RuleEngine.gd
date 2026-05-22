class_name RuleEngine

static func evaluate(applicant_docs: Dictionary, rules: Array, current_date: String) -> Array:
	var violations: Array = []
	for rule in rules:
		var v = _check_rule(rule, applicant_docs, current_date)
		if v != null:
			violations.append(v)
	return violations

static func _check_rule(rule: Dictionary, docs: Dictionary, current_date: String) -> Variant:
	var validation: Dictionary = rule.get("validation", {})
	match validation.get("type", ""):
		"document_required":
			return _check_document_required(rule, validation, docs)
		"field_not_expired":
			return _check_field_not_expired(rule, validation, docs, current_date)
		"name_consistency":
			return _check_name_consistency(rule, validation, docs)
		"field_not_empty":
			return _check_field_not_empty(rule, validation, docs)
	return null

static func _check_document_required(rule: Dictionary, validation: Dictionary, docs: Dictionary) -> Variant:
	var dtype: String = validation.get("document_type", "")
	if not docs.has(dtype):
		return _violation(rule, "Documento requerido ausente: " + dtype)
	return null

static func _check_field_not_expired(rule: Dictionary, validation: Dictionary, docs: Dictionary, current_date: String) -> Variant:
	var dtype: String = validation.get("document_type", "")
	var field: String = validation.get("field", "")
	if not docs.has(dtype):
		return null
	var expiry: String = docs[dtype].get("fields", {}).get(field, "0.0")
	if _is_expired(expiry, current_date):
		return _violation(rule, "Expira: %s | Actual: %s" % [expiry, current_date])
	return null

static func _check_name_consistency(rule: Dictionary, validation: Dictionary, docs: Dictionary) -> Variant:
	var field: String = validation.get("field", "nombre")
	var names: Array = []
	for dtype in docs:
		var val: String = docs[dtype].get("fields", {}).get(field, "").strip_edges().to_lower()
		if val != "":
			names.append(val)
	if names.size() < 2:
		return null
	var first: String = names[0]
	for n in names:
		if n != first:
			return _violation(rule, "Nombres inconsistentes entre documentos")
	return null

static func _check_field_not_empty(rule: Dictionary, validation: Dictionary, docs: Dictionary) -> Variant:
	var dtype: String = validation.get("document_type", "")
	var field: String = validation.get("field", "")
	var invalid: Array = validation.get("invalid_values", [])
	if not docs.has(dtype):
		return null
	var value: String = docs[dtype].get("fields", {}).get(field, "")
	if value == "" or value in invalid:
		return _violation(rule, "Sello invalido: \"%s\"" % value)
	return null

static func _violation(rule: Dictionary, detail: String) -> Dictionary:
	return {
		"rule_id": rule.get("id", ""),
		"description": rule.get("description", ""),
		"display": rule.get("display_text", ""),
		"detail": detail,
	}

static func _is_expired(expiry: String, current: String) -> bool:
	var e := expiry.split(".")
	var c := current.split(".")
	if e.size() < 2 or c.size() < 2:
		return false
	var ec := int(e[0])
	var et := int(e[1])
	var cc := int(c[0])
	var ct := int(c[1])
	return ec < cc or (ec == cc and et < ct)
