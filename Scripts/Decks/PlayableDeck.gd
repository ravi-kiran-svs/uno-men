# This is class acts as a parent class for any deck of cards
# that participate in the game.
extends Deck
class_name PlayableDeck

# notify that the player has finished their turn.
signal PlayerTurnEnd(i, action, card)
signal PlayerDeckEmpty(i)

onready var centrePoint = get_node("CentrePoint")
onready var cardAnim = get_node("%CardSendAnimService")

func _ready():
	DeckService = get_node("%DeckService")

# adds a card to the centre deck.
func _addCardToCentre(card : Card) -> bool:
	var sendSuccess = DeckService.sendCardTo(DeckService.CentreDeck, card)
	if(sendSuccess):
		removeCard(card)
		cardAnim.play(centrePoint.rect_global_position, 
		DeckService.CentreDeck.centrePoint.rect_global_position)
	return sendSuccess

# requests a card from the cards deck.
func _requestCardFromDeck():
	var card = DeckService.requestCardFrom(DeckService.CardsDeck)
	if(card != null):
		addCard(card)
		cardAnim.play(DeckService.CardsDeck.centrePoint.rect_global_position, 
		centrePoint.rect_global_position)
