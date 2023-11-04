extends PlayableDeck

onready var _text = get_node("Label")

func updateView():
	_updateText()
	
func _updateText():
	var text_string = ""
	
	for i in _cards_list.size():
		text_string += String(_cards_list[i]) + " "
	
	_text.text = text_string

func _on_SomethingButton_pressed():
	if(rand_range(0, 2) < 1):
		var card = _cards_list[rand_range(0, _cards_list.size())]
		_addCardToCentre(card)
	
	else:
		_requestCardFromDeck()
