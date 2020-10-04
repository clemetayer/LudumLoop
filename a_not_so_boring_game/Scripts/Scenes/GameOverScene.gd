extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var data = {"cheated" : false}
	Global.save(data)

func _on_TextureButton_pressed():
	get_tree().change_scene("res://Scenes/GameScenes/HiddenLevel.tscn")
