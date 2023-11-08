# This class is responsible for animating a small card 
# flying from one deck to another.
extends Control

onready var tween = get_node("Tween")
onready var cardView = get_node("BackCardView")

export var tTween = 0.5

var _offset = Vector2(-32, -32)

# when an animation is requested, it is played only if the tween is free.
func play(from : Vector2, to : Vector2):
	if	!tween.is_active():
		cardView.visible = true
		cardView.rect_global_position = from + _offset
		
		tween.interpolate_property(cardView, "rect_global_position", 
		from + _offset, to + _offset, tTween, Tween.TRANS_EXPO, Tween.EASE_OUT)
		tween.start()

# the card is set invisible after the animation finishes
func _onTweenCompleted(object, key):
	object.visible = false
