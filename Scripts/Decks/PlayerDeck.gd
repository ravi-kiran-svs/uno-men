# This class is responsible for the deck of cards in the Player's hand.
extends PlayableDeck

onready var _text = get_node("DebugLabel")
onready var _cards = get_node("CenterContainer/Cards")

var CardButton = preload("res://Nodes/CardView.tscn")

func _ready():
	for cardView in _cards.get_children():
		cardView.queue_free()

func updateView():
	_updateDebugText()
	
func _updateDebugText():
	var text_string = ""
	
	for i in _cards_list.size():
		text_string += String(_cards_list[i].colour) + " "
		text_string += String(_cards_list[i].num) + " - "
	
	_text.text = text_string

# overriding the function to update card buttons when new card added.
func addCard(card : Card):
	.addCard(card)
	
	var cardButton = CardButton.instance()
	cardButton.showFront(card)
	_cards.add_child(cardButton)

func removeCard(card : Card):
	.removeCard(card)
	
	# should be changed in future lol - a lot simpler
	for cardView in _cards.get_children():
		if cardView.get_node("BG").frame == card.colour:
			if	cardView.get_node("FG").frame == card.num || (
				card.num == -1 && cardView.get_node("FG").frame == 10):
				cardView.queue_free()
				break

func _on_SendCard_pressed():
	var card = _cards_list[rand_range(0, _cards_list.size())]
	_addCardToCentre(card)
	
	emit_signal("PlayerTurnEnd", 0)

func _on_RequestCard_pressed():
	_requestCardFromDeck()
	
	emit_signal("PlayerTurnEnd", 0)

func _on_TurnStart(i):
	if i == 0:
		$SendCard.disabled = false
		$RequestCard.disabled = false

func _on_TurnEnd(i):
	if i == 0:
		$SendCard.disabled = true
		$RequestCard.disabled = true
