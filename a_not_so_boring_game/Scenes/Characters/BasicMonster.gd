extends Node2D

export var DEFENSE_DIVIDER = 1
export var dialog = []

func _ready():
	pass

func StartDialog():
	get_node("DialogBox").dialog = dialog
	get_node("DialogBox").StartDialog()

func GetHit(amount):
	get_node("HealthBar").removeHealth(int(amount/DEFENSE_DIVIDER))

func noHealth():
	get_parent().get_parent().nextMonster()
	queue_free()
