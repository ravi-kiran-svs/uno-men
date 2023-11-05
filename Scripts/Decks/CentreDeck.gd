# This class is responsible for the deck of cards in the centre.
extends Deck

onready var _text = get_node("Label")

func _ready():
	DeckService = get_node("%DeckService")

func updateView():
	_updateText()
	
func _updateText():
	_text.text = String(_cards_list.back().colour) + " "
	_text.text += String(_cards_list.back().num) + "\n"
	
	var text_string = ""
	for i in _cards_list.size():
		text_string += String(_cards_list[i].colour) + " "
		text_string += String(_cards_list[i].num) + " - "
	_text.text += text_string

# removes and returns all the cards but the top one.
func getAllCardsButTop():
	var cards = []
	for i in _cards_list.size() - 1:
		var card = _cards_list.front()
		cards.append(card)
		removeCard(card)
	
	return cards
	
