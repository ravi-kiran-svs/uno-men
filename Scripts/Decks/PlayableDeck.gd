# This is class acts as a parent class for any deck of cards
# that participate in the game.
extends Deck
class_name PlayableDeck

# notify that the player has finished their turn.
signal PlayerTurnEnd(i)
signal PlayerDeckEmpty(i)

func _ready():
	DeckService = get_node("%DeckService")

# adds a card to the centre deck.
func _addCardToCentre(card : Card) -> bool:
	var sendSuccess = DeckService.sendCardTo(DeckService.CentreDeck, card)
	if(sendSuccess):
		removeCard(card)
	return sendSuccess

# requests a card from the cards deck.
func _requestCardFromDeck():
	var card = DeckService.requestCardFrom(DeckService.CardsDeck)
	if(card != null):
		addCard(card)
