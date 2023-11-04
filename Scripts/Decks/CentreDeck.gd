extends Deck

onready var _text = get_node("Label")

func updateView():
	_updateText()
	
func _updateText():
	_text.text = String(_cards_list.back())
	
	var text_string = "\n"
	
	for i in _cards_list.size():
		text_string += String(_cards_list[i]) + "  - "
	
	_text.text += text_string
