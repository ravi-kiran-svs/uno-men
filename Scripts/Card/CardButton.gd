# This class is resposible for the Button implementation of the CardView.
extends CardView

# emitted when the player clicks on this Card.
signal ButtonPressed(button, card)

# stores the card value it represents
var _card : Card

func setCard(card : Card):
	_card = card
	showFront(card)

func disableButton(disable : bool):
	$Button.disabled = disable

func _onButtonPressed():
	emit_signal("ButtonPressed", self, _card)
