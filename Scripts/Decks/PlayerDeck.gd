extends PlayableDeck

onready var _text = get_node("Label")

func updateView():
	_updateText()
	
func _updateText():
	var text_string = ""
	
	for i in _cards_list.size():
		text_string += String(_cards_list[i]) + " - "
	
	_text.text = text_string

func _on_SendCard_pressed():
	var card = _cards_list[rand_range(0, _cards_list.size())]
	_addCardToCentre(card)
	
	emit_signal("PlayerTurnEnd", 0)

func _on_RequestCard_pressed():
	_requestCardFromDeck()
	
	emit_signal("PlayerTurnEnd", 0)

func _on_TurnStart(i):
	if i == 0:
		$SendCard.disabled = false
		$RequestCard.disabled = false

func _on_TurnEnd(i):
	if i == 0:
		$SendCard.disabled = true
		$RequestCard.disabled = true
