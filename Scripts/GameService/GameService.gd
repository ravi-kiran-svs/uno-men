extends Control

signal GameStart
signal TurnStart(i)
signal TurnEnd(i)

onready var DeckService = get_node("%DeckService")

func _startTurn(i):
	emit_signal("TurnStart", i)

func _on_StartGame_pressed():
	$StartGame.disabled = true;
	
	emit_signal("GameStart")
	_startTurn(0)

func _on_PlayerTurnEnd(i : int):
	emit_signal("TurnEnd", i)
	
	if	DeckService.getCentreCard().num == -1:
		_startTurn(i)
	else:
		_startTurn((i + 1) % 2)

func _on_PlayerDeckEmpty(i : int):
	if i == 0:
		print("YOU WIN")
	
	else:
		print("YOU LOSE")
