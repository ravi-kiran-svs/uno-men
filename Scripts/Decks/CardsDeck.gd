extends Deck

onready var _text = get_node("Label")

func _ready():
	DeckService = get_node("%DeckService")

func shuffleAndSplit(deck, n):
	_cards_list.append_array(deck)
	_cards_list.shuffle();
	
	for i in n:
		_addTopCardTo(DeckService.PlayerDeck)
		_addTopCardTo(DeckService.BotDeck)
	
	_addTopCardTo(DeckService.CentreDeck)

func removeCard(i : int):
	.removeCard(i)
	
	if(_cards_list.size() <= 1):
		var cards = DeckService.requestRefill()
		cards.shuffle()
		_cards_list.append_array(cards)
		updateView()

func updateView():
	_updateText()
	
func _updateText():
	var text_string = ""
	
	for i in _cards_list.size():
		text_string += String(_cards_list[i]) + " "
	
	_text.text = text_string

func _addTopCardTo(to : Deck):
	if(!isEmpty()):
		var card = _cards_list.front()
		
		var sendSuccess = DeckService.sendCardTo(to, card)
		
		if(sendSuccess):
			removeCard(card)
