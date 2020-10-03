extends Control

export var HEALTH = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("HealthProgress").value = HEALTH

func removeHealth(amount):
	HEALTH -= amount
	get_node("HealthProgress").value = HEALTH
	if(HEALTH <= 0):
		get_parent().noHealth()
