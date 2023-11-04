extends Deck
class_name PlayableDeck

func _addCardToCentre(i : int):
	var sendSuccess = get_node("%DeckService").sendCardTo(
		get_node("%DeckService").CentreDeck, i)
	
	if(sendSuccess):
		removeCard(i)

func _requestCardFromDeck():
	var card = get_node("%DeckService").requestCardFrom(
		get_node("%DeckService").CardsDeck)
	
	if(card != null):
		addCard(card)
