extends Node
class_name Menu

onready var _anim = get_node("AnimationPlayer")

func playEnterAnim():
	_anim.play("enter")

func playExitAnim():
	_anim.play("exit")
