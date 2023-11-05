extends Node
class_name Deck

var DeckService

var _cards_list = []

func addCard(i : int):
	_cards_list.push_back(i)
	updateView()

func removeCard(i : int):
	_cards_list.erase(i)
	updateView()

func getTopCard():
	if(isEmpty()):
		return null
	
	else:
		var card = _cards_list.front()
		removeCard(card)
		return card

func peekBackCard() -> int:
	return _cards_list.back()

func isEmpty() -> bool:
	return _cards_list.empty()

func updateView():
	pass
