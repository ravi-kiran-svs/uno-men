extends Deck
class_name PlayableDeck

func _ready():
	DeckService = get_node("%DeckService")

func _addCardToCentre(i : int):
	var sendSuccess = DeckService.sendCardTo(
		DeckService.CentreDeck, i)
	
	if(sendSuccess):
		removeCard(i)

func _requestCardFromDeck():
	var card = DeckService.requestCardFrom(
		DeckService.CardsDeck)
	
	if(card != null):
		addCard(card)
