class_name DecisionSystem
extends Node

signal decision_recorded(result: Dictionary)

var _decisions: Array = []
var _credits: int = 50
var _correct: int = 0
var _errors: int = 0

func setup(starting_credits: int) -> void:
	_credits = starting_credits
	_decisions = []
	_correct = 0
	_errors = 0

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

	var result := {
		"applicant_id": applicant.get("id", ""),
		"applicant_name": applicant.get("name", ""),
		"decision": decision,
		"correct_decision": correct_decision,
		"was_correct": was_correct,
		"risk_level": risk,
		"violations": truth.get("violations", []),
		"credit_delta": delta,
		"credits_after": _credits,
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
	}
