# A custom class that represents a Card.
extends Object
class_name Card

enum CardColour {RED = 0, YELLOW = 1, GREEN = 2, BLUE = 3}

# every card has two properties - a colour and a number.
var colour : int
var num : int
# num == -1 => it's a SKIP TURN card.

func _init(col : int, n : int):
	colour = col
	num = n
