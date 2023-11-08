# A custom class that represents a deck of cards.
extends Node
class_name Deck

var DeckService : Node

var _cards_list = []

func addCard(card : Card):
	_cards_list.push_back(card)
	updateView()

func removeCard(card : Card):
	_cards_list.erase(card)
	updateView()

func getTopCard():
	if(isEmpty()):
		return null

	else:
		var card = _cards_list.front()
		removeCard(card)
		return card

func peekTopCard() -> Card:
	return _cards_list.back()

func isEmpty() -> bool:
	return _cards_list.empty()

func emptyDeck():
	_cards_list.clear()
	updateView()

func updateView():
	pass
