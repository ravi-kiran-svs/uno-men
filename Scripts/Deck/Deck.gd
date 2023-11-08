# A custom class that represents a deck of cards.
extends Node
class_name Deck

var DeckService : Node

# deck consists of a list of cards (an array).
var _cards_list = []

# this method must be overriden to perform 
# important changes to the UI when the cards list is altered.
func updateView():
	pass

func addCard(card : Card):
	_cards_list.push_back(card)
	updateView()

func removeCard(card : Card):
	_cards_list.erase(card)
	updateView()

# override this method if 'top card' is different that front().
func getTopCard():
	if(isEmpty()):
		return null

	else:
		var card = _cards_list.front()
		removeCard(card)
		return card

# override this method if 'top card' is different that back().
func peekTopCard() -> Card:
	return _cards_list.back()

func isEmpty() -> bool:
	return _cards_list.empty()

# clears the entire deck.
func emptyDeck():
	_cards_list.clear()
	updateView()
