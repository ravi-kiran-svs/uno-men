extends Deck

onready var _text = get_node("Label")

func _ready():
	DeckService = get_node("%DeckService")

func updateView():
	_updateText()
	
func _updateText():
	_text.text = String(_cards_list.back())
	
	var text_string = "\n"
	for i in _cards_list.size():
		text_string += String(_cards_list[i]) + " "
	_text.text += text_string

func getAllCardsButTop():
	var cards = []
	for i in _cards_list.size() - 1:
		var card = _cards_list.front()
		cards.append(card)
		removeCard(card)
	
	return cards
		
	
