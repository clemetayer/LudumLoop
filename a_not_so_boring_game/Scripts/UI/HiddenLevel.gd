extends Node2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("Crosshair").position = get_global_mouse_position()

func getPlayerPosition():
	return get_node("Hero").position

func nextDialog(target):
	if(target == "Player"):
		get_node("Hero").canTalk = true
	else:
		get_node("Ennemy").canTalk = true

func dialogDone():
	get_node("Hero").dialogDone = true
