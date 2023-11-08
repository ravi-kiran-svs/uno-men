extends PlayableDeck

export var tThink : float = 3

onready var _text = get_node("DebugLabel")
onready var _cards = get_node("CenterContainer/Cards")
onready var _think = get_node("ThinkingIcon")
onready var _unoCloudAnim = get_node("UNOTextCloud/AnimationPlayer")

func _ready():
	for i in range(1, 10):
		_cards.get_node("Card" + str(i)).visible = false

func updateView():
	_updateCardsView()
	_updateDebugText()

# updates the CardViews in the centre deck
func _updateCardsView():
	var n = _cards_list.size()
	
	for i in range(1, 10):
		_cards.get_node("Card" + str(i)).visible = n>=i

# used for debugging purposes.
func _updateDebugText():
	var text_string = ""
	
	for i in _cards_list.size():
		text_string += String(_cards_list[i].colour) + " "
		text_string += String(_cards_list[i].num) + " - "
	
	_text.text = text_string

func _takeAction():
	var cardsAvailable = []
	var centreCard = DeckService.getCentreCard()
	
	for	card in _cards_list:
		if	centreCard.colour == card.colour || centreCard.num == card.num:
			cardsAvailable.append(card)
	
	if	cardsAvailable.size() == 0:
		_requestCardFromDeck()
		emit_signal("PlayerTurnEnd", 1, GameService.Action.RECEIVE_CARD, null)
	
	else:
		var cardToSend
		
		var isTurnSkipper = false
		for	card in cardsAvailable:
			if	card.num == -1:
				isTurnSkipper = true
				cardToSend = card
				break
		
		if(!isTurnSkipper):
			cardToSend = cardsAvailable[rand_range(0, cardsAvailable.size())]
		
		var sendSuccess = _addCardToCentre(cardToSend)
		if(sendSuccess):
			if	_cards_list.size() == 1:
				_unoCloudAnim.play("move_down")
			
			if	_cards_list.size() == 0:
				emit_signal("PlayerDeckEmpty", 1)
			else:
				emit_signal("PlayerTurnEnd", 1, 
				GameService.Action.PLAY_CARD, cardToSend)

func _on_TurnStart(i):
	if i == 1:
		_think.visible = true
		yield(get_tree().create_timer(tThink), "timeout")
		
		_think.visible = false
		_takeAction()

func _on_TurnEnd(i):
	if i == 1:
		pass
