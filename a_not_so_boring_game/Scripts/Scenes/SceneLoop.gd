extends Node2D

export var NARRATOR_DIALOG = []
export var MONSTERS = []

var EndSceneLoop = preload("res://Scenes/GameScenes/EndSceneLoop.tscn")
var EndSceneLoopAlternative = preload("res://Scenes/GameScenes/EndSceneLoopAltenative.tscn")

var lvl = 1
var dialogIndex = 0
var monsterIndex = 0
var cheatEntered = false
var cheatString = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("LevelDialog/Level").set_bbcode(generateBBCode(str("Level : ", lvl)))
	get_node("HitButton").disabled = true
	get_node("DialogBox").dialog = NARRATOR_DIALOG[dialogIndex]
	get_node("DialogBox").StartDialog()

func _process(delta):
	if(not get_node("DialogBox").StartDialog and get_node("HitButton").disabled):
		get_node("HitButton").disabled = false
		dialogIndex += 1
		get_node("Monsters").get_node(MONSTERS[monsterIndex]).show()
		get_node("Monsters").get_node(MONSTERS[monsterIndex]).StartDialog()
		

func _input(event):
	if(event is InputEventKey and event.pressed):
		cheatString += event.as_text()
		if(cheatString.length() > 5):
			cheatString = cheatString.substr(1,5)
		cheatEntered = (cheatString == "LUDUM")

func nextMonster():
	if(monsterIndex >= 9):
		var data = Global.loadSave()
		var cheatValue = data.cheated
		if(cheatValue):
			get_tree().change_scene_to(EndSceneLoopAlternative)
		else:
			get_tree().change_scene_to(EndSceneLoop)
			
	else:
		monsterIndex += 1
		lvl += 1
		get_node("LevelDialog/Level").set_bbcode(generateBBCode(str("Level : ", lvl)))
		get_node("HitButton").disabled = true
		get_node("DialogBox").dialog = NARRATOR_DIALOG[dialogIndex]
		get_node("DialogBox").StartDialog()

func generateBBCode(string):
	return(str("[center][color=lime][tornado radius=5 freq=2]\n", string, "[/tornado][/color][/center]"))

func _on_HitButton_pressed():
	if(cheatEntered):
		var data = {"cheated" : true}
		Global.save(data)
		get_tree().quit()
	else:
		get_node("SlashAnimation").play("Slash")
		get_node("Monsters").get_node(MONSTERS[monsterIndex]).GetHit(5 * lvl)

func _on_SlashAnimation_animation_finished():
	get_node("SlashAnimation").stop()
