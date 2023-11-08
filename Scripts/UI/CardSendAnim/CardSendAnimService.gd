extends Control

onready var tween = get_node("Tween")
onready var cardView = get_node("BackCardView")

export var tTween = 0.5

var _offset = Vector2(-32, -32)

func play(from : Vector2, to : Vector2):
	if	!tween.is_active():
		cardView.visible = true
		cardView.rect_global_position = from + _offset
		
		tween.interpolate_property(cardView, "rect_global_position", 
		from + _offset, to + _offset, tTween, Tween.TRANS_EXPO, Tween.EASE_OUT)
		tween.start()

func _onTweenCompleted(object, key):
	object.visible = false
