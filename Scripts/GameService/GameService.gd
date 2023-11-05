extends Control

signal GameStart
signal TurnStart(i)
signal TurnEnd(i)

func _startTurn(i):
	emit_signal("TurnStart", i)

func _on_StartGame_pressed():
	$StartGame.disabled = true;
	
	emit_signal("GameStart")
	_startTurn(0)

func _on_PlayerTurnEnd(i):
	if i == 0:
		emit_signal("TurnEnd", 0)
		_startTurn(1)
	
	else:
		emit_signal("TurnEnd", 1)
		_startTurn(0)
