extends Node2D

var HiddenLevel = preload("res://Scenes/GameScenes/HiddenLevel.tscn")

func _on_Timer_timeout():
	get_tree().change_scene_to(HiddenLevel)
