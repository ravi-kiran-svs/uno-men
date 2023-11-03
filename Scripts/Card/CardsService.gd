extends Node
class_name CardsService

var _cards_list = []

func addCard(i : int):
	_cards_list.append(i)
	updateView()

func removeCard(i : int):
	_cards_list.erase(i)
	updateView()

func updateView():
	pass
