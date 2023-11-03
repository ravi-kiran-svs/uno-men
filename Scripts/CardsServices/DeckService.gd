extends CardsService

onready var _text = get_node("Label")

func shuffleAndSplit(n):
	_cards_list.shuffle();
	
	for i in n:
		_addTopCardTo(get_node("%PlayerCardsService"))
		_addTopCardTo(get_node("%BotCardsService"))
	
	_addTopCardTo(get_node("%CentreCardsService"))

func updateView():
	_updateText()
	
func _updateText():
	var text_string = ""
	
	for i in _cards_list.size():
		text_string += String(_cards_list[i]) + " "
	
	_text.text = text_string

func _addTopCardTo(cardsPack : CardsService):
		var card = _cards_list.front()
		removeCard(card)
		cardsPack.addCard(card)
