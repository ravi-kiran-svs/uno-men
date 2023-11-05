# This class is responsible for the deck of cards
# from which the player and the bot draw the cards from.
extends Deck

onready var _text = get_node("Label")

func _ready():
	DeckService = get_node("%DeckService")

# called at the start of a round.
# 1. adds the cards into the deck.
# 2. shuffles the deck.
# 3. splits the cards to the player and the bot.
# 4. places a card onto the centre deck.
func shuffleAndSplit(deck, n):
	_cards_list.append_array(deck)
	_cards_list.shuffle();
	
	for i in n:
		_addTopCardTo(DeckService.PlayerDeck)
		_addTopCardTo(DeckService.BotDeck)
	
	_addTopCardTo(DeckService.CentreDeck)

# overrides the method in parent class.
func removeCard(card : Card):
	.removeCard(card)
	
	# checks if the deck is out of cards.
	# if yes => requests new cards, shuffles and adds into the deck.
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
		text_string += String(_cards_list[i].colour) + " "
		text_string += String(_cards_list[i].num) + " - "
	
	_text.text = text_string

# sends the top card to other decks.
func _addTopCardTo(to : Deck):
	if(!isEmpty()):
		var card = _cards_list.front()
		
		var sendSuccess = DeckService.sendCardTo(to, card)
		
		if(sendSuccess):
			removeCard(card)
