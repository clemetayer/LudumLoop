extends Node2D

var SceneLoop = preload("res://Scenes/GameScenes/SceneLoop.tscn")
var CorruptScene = preload("res://Scenes/GameScenes/CorruptScene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var data = Global.loadSave()
	var cheatValue = data.cheated
	if(cheatValue):
		get_node("HitCorrupt").show()
	else:
		get_node("HitCorrupt").hide()

func _on_PlayButton_pressed():
	get_tree().change_scene_to(SceneLoop)


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_HitCorrupt_pressed():
	get_tree().change_scene_to(CorruptScene)
