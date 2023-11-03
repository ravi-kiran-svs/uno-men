extends Node

onready var _rect = get_node("ColorRect")

func _ready():
	randomize()

func _on_Button_pressed():
	_rect.color = Color(randf(), randf(), randf())
