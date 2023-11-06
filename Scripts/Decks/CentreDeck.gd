# This class is responsible for the deck of cards in the centre.
extends Deck

onready var _text = get_node("DebugLabel")
onready var _topCard = get_node("TopCard")
onready var _deckCards = get_node("DeckCards")

func _ready():
	DeckService = get_node("%DeckService")

func updateView():
	_updateCardsView()
	_updateDebugText()

# updates the CardViews in the centre deck
func _updateCardsView():
	_topCard.showFront(_cards_list.back())
	
	var n = _cards_list.size()
	_deckCards.get_node("DeckCard1").visible = n>=2
	_deckCards.get_node("DeckCard2").visible = n>=3
	_deckCards.get_node("DeckCard3").visible = n>=4

# used for debugging purposes.
func _updateDebugText():
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

func _onGameStart():
	self.visible = true
