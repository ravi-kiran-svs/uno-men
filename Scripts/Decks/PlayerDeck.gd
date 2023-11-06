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
	cardButton.connect("ButtonPressed", self, "_onCardButtonPressed")
	_cards.add_child(cardButton)
	#move child etc - to rearrange

func _onCardButtonPressed(button : Node, card : Card):
	var sendSuccess = _addCardToCentre(card)
	if(sendSuccess):
		button.queue_free()
		
		if(_cards_list.size() == 0):
			emit_signal("PlayerDeckEmpty", 0)
		else:
			emit_signal("PlayerTurnEnd", 0)

func _on_RequestCard_pressed():
	_requestCardFromDeck()
	
	emit_signal("PlayerTurnEnd", 0)

func _on_TurnStart(i):
	if i == 0:
		$RequestCard.disabled = false
		for cardButton in _cards.get_children():
			cardButton.disableButton(false)

func _on_TurnEnd(i):
	if i == 0:
		$RequestCard.disabled = true
		for cardButton in _cards.get_children():
			cardButton.disableButton(true)
