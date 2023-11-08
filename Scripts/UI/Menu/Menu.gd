# This class represents a Menu object
extends Node
class_name Menu

# this animation player must contain two animations.
# 1. enter - played when menu is called to enter the screen.
# 2. exit - played when menu is exited from the screen.
onready var _anim = get_node("AnimationPlayer")

func playEnterAnim():
	_anim.play("enter")

func playExitAnim():
	_anim.play("exit")
