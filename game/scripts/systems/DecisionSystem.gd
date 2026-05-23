class_name DecisionSystem
extends Node

signal decision_recorded(result: Dictionary)

var _decisions: Array = []
var _credits: int = 50
var _correct: int = 0
var _errors: int = 0
var _activated_flags: Array = []

func setup(starting_credits: int) -> void:
	_credits = starting_credits
	_decisions = []
	_correct = 0
	_errors = 0
	_activated_flags = []

func record(decision: String, applicant: Dictionary) -> Dictionary:
	var truth: Dictionary = applicant.get("truth", {})
	var correct_decision: String = truth.get("correct_decision", "")
	var was_correct: bool = (decision == correct_decision)
	var risk: String = truth.get("risk_level", "low")

	var delta := _credit_delta(decision, was_correct, risk)
	_credits += delta

	if was_correct:
		_correct += 1
	else:
		_errors += 1

	var hooks: Dictionary = applicant.get("narrative_hooks", {})
	var hook_key := "on_%s_%s" % ["correct" if was_correct else "wrong", decision]
	var narrative_flag: String = ""
	if hooks.has(hook_key):
		narrative_flag = str(hooks[hook_key])
		if narrative_flag != "" and narrative_flag not in _activated_flags:
			_activated_flags.append(narrative_flag)
			print("[NarrativeHook] Flag activado: %s (solicitante: %s)" % [narrative_flag, applicant.get("name", "?")])

	var result := {
		"applicant_id":      applicant.get("id", ""),
		"applicant_name":    applicant.get("name", ""),
		"applicant_type":    applicant.get("type", ""),
		"applicant_origin":  applicant.get("origin", ""),
		"applicant_purpose": applicant.get("purpose", ""),
		"decision":          decision,
		"correct_decision":  correct_decision,
		"was_correct":       was_correct,
		"risk_level":        risk,
		"violations":        truth.get("violations", []),
		"credit_delta":      delta,
		"credits_after":     _credits,
		"narrative_flag":    narrative_flag,
		"report":            applicant.get("report", {}),
	}
	_decisions.append(result)
	decision_recorded.emit(result)
	return result

func _credit_delta(decision: String, was_correct: bool, risk: String) -> int:
	if was_correct:
		return 0
	match decision:
		"approve":
			return -15 if risk == "high" else -10
		"reject":
			return -10
		"hold":
			return -5
	return 0

func get_credits() -> int:
	return _credits

func get_correct() -> int:
	return _correct

func get_errors() -> int:
	return _errors

func get_decisions() -> Array:
	return _decisions

func get_summary() -> Dictionary:
	return {
		"total": _decisions.size(),
		"correct": _correct,
		"errors": _errors,
		"credits": _credits,
		"decisions": _decisions,
		"activated_flags": _activated_flags,
	}
