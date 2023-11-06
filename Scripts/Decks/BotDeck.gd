extends PlayableDeck

export var tThink : float = 3

onready var _text = get_node("DebugLabel")
onready var _cards = get_node("CenterContainer/Cards")

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
	if(rand_range(0, 2) < 1):
		var card = _cards_list[rand_range(0, _cards_list.size())]
		
		var sendSuccess = _addCardToCentre(card)
		if(sendSuccess):
			if(_cards_list.size() == 0):
				emit_signal("PlayerDeckEmpty", 1)
			else:
				emit_signal("PlayerTurnEnd", 1)
	
	else:
		_requestCardFromDeck()
		emit_signal("PlayerTurnEnd", 1)

func _on_TurnStart(i):
	if i == 1:
		yield(get_tree().create_timer(tThink), "timeout")
		_takeAction()

func _on_TurnEnd(i):
	if i == 1:
		pass
