class_name ApplicantQueue
extends Node

signal applicant_changed(applicant: Dictionary)
signal day_ended(total_processed: int)

var _applicants: Array = []
var _current_index: int = -1
var _processed: int = 0

func load_applicants(applicants: Array) -> void:
	_applicants = applicants
	_current_index = -1
	_processed = 0

func start() -> void:
	if _applicants.is_empty():
		day_ended.emit(0)
		return
	_current_index = 0
	applicant_changed.emit(get_current())

func advance() -> void:
	_processed += 1
	_current_index += 1
	if _current_index >= _applicants.size():
		day_ended.emit(_processed)
	else:
		applicant_changed.emit(get_current())

func get_current() -> Dictionary:
	if _current_index < 0 or _current_index >= _applicants.size():
		return {}
	return _applicants[_current_index]

func get_current_index() -> int:
	return _current_index

func get_total() -> int:
	return _applicants.size()

func get_processed() -> int:
	return _processed

func is_finished() -> bool:
	return _current_index >= _applicants.size()
