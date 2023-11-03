extends Control

var N = 5;

func _ready():
	
	# 1
	# we must use append cards method instead here
	for i in range(5, 20):
		get_node("%DeckCardsService").addCard(i)
	
	# 2
	# this must contain #3 also
	# can be done all in the same method lol.
	get_node("%DeckCardsService").shuffleAndSplit(N)

# things to do at the start of the game - when player clicks Start Game button
# 1. create the cards and add them into the deck
# 2. shuffle the deck and split it to the players (from the top of the deck)
# 3. pick the top card from the deck and add it into the centre cards
