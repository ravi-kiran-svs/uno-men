extends Control
class_name GameService

signal GameStart
signal TurnStart(i)
signal TurnEnd(i)

enum Action {PLAY_CARD = 0, RECEIVE_CARD = 1}

onready var DeckService = get_node("%DeckService")

func _startTurn(i):
	emit_signal("TurnStart", i)

func _on_StartGame_pressed():
	$StartGame.disabled = true;
	
	emit_signal("GameStart")
	_startTurn(0)

func _on_PlayerTurnEnd(i : int, action : int, card : Card):
	emit_signal("TurnEnd", i)
	
	if	action == Action.PLAY_CARD && card.num == -1:
		_startTurn(i)
	else:
		_startTurn((i + 1) % 2)

func _on_PlayerDeckEmpty(i : int):
	if i == 0:
		print("YOU WIN")
	
	else:
		print("YOU LOSE")
