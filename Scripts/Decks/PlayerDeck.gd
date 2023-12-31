# This class is responsible for the deck of cards in the Player's hand.
extends PlayableDeck

var CardButton = preload("res://Nodes/Card/CardButton.tscn")

onready var _text = get_node("DebugLabel")
onready var _cards = get_node("CenterContainer/Cards")
onready var _unoCloudAnim = get_node("UNOTextCloud/AnimationPlayer")
onready var _requestCard = get_node("RequestCard/Button")

func _ready():
	_requestCard.disabled = true
	for cardView in _cards.get_children():
		cardView.queue_free()

func updateView():
	_updateDebugText()

# used for debugging purposes.
func _updateDebugText():
	var text_string = ""
	
	for i in _cards_list.size():
		text_string += String(_cards_list[i].colour) + " "
		text_string += String(_cards_list[i].num) + " - "
	
	_text.text = text_string

# overriding the function to update card buttons when new card added.
# card buttons are added in a sorted order - RED, YELLOW, BLUE and GREEN.
func addCard(card : Card):
	.addCard(card)
	
	var cardButton = CardButton.instance()
	cardButton.setCard(card)
	cardButton.connect("ButtonPressed", self, "_onCardButtonPressed")
	
	var posToAdd = _cards.get_child_count()
	for	i in _cards.get_child_count():
		var cardI = _cards.get_child(i)._card
		
		if	cardButton._card.colour < cardI.colour:
			posToAdd = i
			break
		
		elif	cardButton._card.colour == cardI.colour:
			if	cardButton._card.num < cardI.num:
				posToAdd = i
				break
	
	_cards.add_child(cardButton)
	_cards.move_child(cardButton, posToAdd)

func emptyDeck():
	.emptyDeck()
	
	for cardButton in _cards.get_children():
		cardButton.queue_free()

# when a card is pressed to be played.
func _onCardButtonPressed(button : Node, card : Card):
	var sendSuccess = _addCardToCentre(card)
	if(sendSuccess):
		button.queue_free()
		
		if	_cards_list.size() == 1:
			_unoCloudAnim.play("move_up")
		
		if	_cards_list.size() == 0:
			emit_signal("PlayerDeckEmpty", 0)
		else:
			emit_signal("PlayerTurnEnd", 0, GameService.Action.PLAY_CARD, card)

func _on_RequestCard_pressed():
	_requestCardFromDeck()
	
	emit_signal("PlayerTurnEnd", 0, GameService.Action.RECEIVE_CARD, null)

# when the player's turn starts
# buttons that match the centre card are the only ones to be set active.
# if no button is active => request button is set active.
func _on_TurnStart(i):
	if i == 0:
		var nAvailableCards = 0
		var centreCard = DeckService.getCentreCard()
		
		for	button in _cards.get_children():
			if	!button.is_queued_for_deletion():
				var card = button._card
				
				if	centreCard.colour == card.colour || centreCard.num == card.num:
					button.disableButton(false)
					nAvailableCards += 1
				else:
					button.disableButton(true)
		
		if(nAvailableCards == 0):
			_requestCard.disabled = false

# all buttons are disabled when the turn is over.
func _on_TurnEnd(i):
	if i == 0:
		_requestCard.disabled = true
		for cardButton in _cards.get_children():
			cardButton.disableButton(true)
