# This class is responsible for the interface of the Card
extends Control

func showBack():
	$BG.frame = 4
	$FG.visible = false;

func showFront(card : Card):
	$BG.frame = card.colour
	
	$FG.visible = true;
	if card.num == -1:
		$FG.frame = 10
	else:
		$FG.frame = card.num

