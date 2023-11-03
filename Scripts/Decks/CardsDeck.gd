extends Deck

onready var _text = get_node("Label")

func shuffleAndSplit(deck, n):
	_cards_list.append_array(deck)
	_cards_list.shuffle();
	
	for i in n:
		_addTopCardTo(get_node("%DeckService").PlayerDeck)
		_addTopCardTo(get_node("%DeckService").BotDeck)
	
	_addTopCardTo(get_node("%DeckService").CentreDeck)

func updateView():
	_updateText()
	
func _updateText():
	var text_string = ""
	
	for i in _cards_list.size():
		text_string += String(_cards_list[i]) + " "
	
	_text.text = text_string

func _addTopCardTo(to : Deck):
	var card = _cards_list.front()
	
	var sendSuccess = get_node("%DeckService").sendCardTo(to, card)
	
	if(sendSuccess):
		removeCard(card)
