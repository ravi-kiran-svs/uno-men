# This class is responsible for the Arrow that points 
# towards the player with the current turn.
extends TextureRect

# the tween is used to animate between two angles.
onready var tween = get_node("Tween")

export var tTween = 0.1

func turn(from : int, to : int):
	var fromAngle
	var toAngle
	
	if	from == 0 && to == 0:
		fromAngle = 0
		toAngle = 360
	
	elif from == 0 && to == 1:
		fromAngle = 0
		toAngle = 180
	
	elif from == 1 && to == 0:
		fromAngle = 180
		toAngle = 360
	
	else:
		fromAngle = -180
		toAngle = 180
	
	fromAngle += 180
	toAngle += 180
		
	tween.interpolate_property(self, "rect_rotation", 
	fromAngle, toAngle, tTween, Tween.TRANS_EXPO, Tween.EASE_OUT)
	tween.start()
