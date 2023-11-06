extends CardView

signal ButtonPressed(button, card)

var _card : Card

func setCard(card : Card):
	_card = card
	showFront(card)

func disableButton(disable : bool):
	$Button.disabled = disable

func _onButtonPressed():
	emit_signal("ButtonPressed", self, _card)
