# This class is responsible for all communication between different decks.
extends Control

# initial number of cards each played gets.
export var N : int = 5;

# these are the four decks of cards used in the game.
onready var CardsDeck := get_node("CardsDeck")
onready var CentreDeck := get_node("CentreDeck")
onready var PlayerDeck := get_node("PlayerDeck")
onready var BotDeck := get_node("BotDeck")

func _ready():
	randomize()

# used to send card from one deck to another.
func sendCardTo(to : Deck, card : Card) -> bool:
	to.addCard(card)
	return true

# used to request card from a deck.
func requestCardFrom(from : Deck) -> Card:
	return from.getTopCard()

# called by CardsDeck when it is out of cards.
func requestRefill():
	return CentreDeck.getAllCardsButTop()

# this function is called when the Game Starts - signal from GameService
# 1. create the initial deck of cards.
# 2. send it to CardsDeck to be shuffled and split.
func _onGameStart():
	var initialDeck = []
	for c in 4:
		for n in range(-1, 10):
			initialDeck.append(Card.new(c, n))
	
	CardsDeck.shuffleAndSplit(initialDeck, N)
