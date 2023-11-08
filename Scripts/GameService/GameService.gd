# This class is responsible for the main game loop.
extends Control
class_name GameService

signal GameStart
signal TurnStart(i)
signal TurnEnd(i)
signal PlayerWin
signal PlayerLose

enum Action {PLAY_CARD = 0, RECEIVE_CARD = 1}

onready var DeckService = get_node("%DeckService")
onready var arrow = get_node("TurnArrow")

var _currentTurn = 0

func _ready():
	arrow.visible = false

# arrow is turned towards the player whose turn it is.
func _startTurn(i):
	arrow.turn(_currentTurn, i)
	
	_currentTurn = i
	emit_signal("TurnStart", i)

func _on_PlayButton_pressed():
	arrow.visible = true
	
	emit_signal("GameStart")
	_startTurn(0)

func _on_ReplayButton_pressed():
	DeckService.emptyAllDecks()
	
	_on_PlayButton_pressed()

# when a turn ends, checks for turn skipper.
# if yes => skips the next turn.
func _on_PlayerTurnEnd(i : int, action : int, card : Card):
	emit_signal("TurnEnd", i)
	
	if	action == Action.PLAY_CARD && card.num == -1:
		_startTurn(i)
	else:
		_startTurn((i + 1) % 2)

# deck being empty is the state of winner.
func _on_PlayerDeckEmpty(i : int):
	if	i == 0:
		emit_signal("PlayerWin")
	else:
		emit_signal("PlayerLose")
	
	get_node("%MenuService").changeMenuTo(MenuService.Menus.GAME_OVER_MENU)

