extends Node
class_name Deck

var _cards_list = []

func addCard(i : int):
	_cards_list.append(i)
	updateView()

func removeCard(i : int):
	_cards_list.erase(i)
	updateView()

func getTopCard() -> int:
	var card = _cards_list.front()
	if(card != null):
		removeCard(card)
	return card

func updateView():
	pass
