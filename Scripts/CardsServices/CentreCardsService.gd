extends CardsService

onready var _text = get_node("Label")

func updateView():
	_updateText()
	
func _updateText():
	_text.text = String(_cards_list.front())
