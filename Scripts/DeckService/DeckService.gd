extends Control

var N = 5;

onready var CardsDeck = get_node("CardsDeck")
onready var CentreDeck = get_node("CentreDeck")
onready var PlayerDeck = get_node("PlayerDeck")
onready var BotDeck = get_node("BotDeck")

func _ready():
	randomize()

# more complex code consisting of loops and conditions.
func sendCardTo(to : Deck, i : int):
	to.addCard(i)
	return true

func requestCardFrom(from : Deck) -> int:
	return from.getTopCard()

func requestRefill():
	return CentreDeck.getAllCardsButTop()

# things to do at the start of the game - when player clicks Start Game button.
# 1. create the cards and add them into the deck.
# 2. shuffle the deck and split it to the players (from the top of the deck).
# 3. pick the top card from the deck and add it into the centre cards.

func _on_StartGame_pressed():
	get_node("StartGame").disabled = true;
	
	var initialDeck = []
	for i in range(5, 20):
		initialDeck.append(i)
	
	CardsDeck.shuffleAndSplit(initialDeck, N)
