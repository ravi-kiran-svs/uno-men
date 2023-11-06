# This class is responsible for the deck of cards in the Player's hand.
extends PlayableDeck

onready var _text = get_node("DebugLabel")
onready var _cards = get_node("CenterContainer/Cards")

var CardButton = preload("res://Nodes/Card/CardButton.tscn")

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
	cardButton.setCard(card)
	cardButton.connect("ButtonPressed", self, "_onButtonPressed")
	_cards.add_child(cardButton)
	#move child etc - to rearrange

func _onButtonPressed(button : Node, card : Card):
	var sendSuccess = _addCardToCentre(card)
	if(sendSuccess):
		button.queue_free()
	
	emit_signal("PlayerTurnEnd", 0)

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
