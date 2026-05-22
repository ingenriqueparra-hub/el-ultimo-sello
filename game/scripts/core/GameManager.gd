extends Node

enum GameState {
	MAIN_MENU,
	START_DAY,
	APPLICANT_ARRIVAL,
	INSPECTION,
	DECISION_MADE,
	NEXT_APPLICANT,
	DAY_REPORT,
	GAME_OVER_OR_NEXT_DAY
}

var current_state: GameState = GameState.MAIN_MENU

func _ready() -> void:
	print("[GameManager] El Último Sello iniciado.")
	print("[GameManager] Estado inicial: ", GameState.keys()[current_state])

func change_state(new_state: GameState) -> void:
	current_state = new_state
	print("[GameManager] Estado: ", GameState.keys()[current_state])
