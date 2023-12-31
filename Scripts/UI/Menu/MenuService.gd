# This class is responsible for handling the transitions 
# between different menus and screens.
extends Control
class_name MenuService

# this class behaves similar to a State Machine with three States.
enum Menus {MAIN_MENU = 0, GAME = 1, GAME_OVER_MENU = 2}

onready var menuList = [
	get_node("MainMenu"),
	get_node("Game"),
	get_node("GameOverMenu")]

var _currentMenu : int = Menus.MAIN_MENU

func changeMenuTo(newMenu : int):
	menuList[_currentMenu].playExitAnim()
	menuList[newMenu].playEnterAnim()
	_currentMenu = newMenu
