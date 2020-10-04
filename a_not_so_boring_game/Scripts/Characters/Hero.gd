extends KinematicBody2D

export var SPEED = 5
export var DIALOG = []

var RedProjectile = preload("res://Scenes/Projectiles/RedFireball.tscn")
var GameOverScene = preload("res://Scenes/GameScenes/GameOverScene.tscn")

var dialogDone = false
var canTalk = false
var dialogPagePrinting = false
var dialogPage = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	canTalk = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(dialogDone):
		inputManagement()
	elif(canTalk):
		var dialogBox = get_node("DialogBox")
		if(not dialogBox.StartDialog and not dialogPagePrinting): #Dialog not started
			dialogBox.dialog = DIALOG[dialogPage]
			dialogBox.StartDialog()
			dialogPagePrinting = true
		elif(not dialogBox.StartDialog and dialogPagePrinting): #Dialog done
			dialogPagePrinting = false
			canTalk = false
			dialogPage += 1
			get_parent().nextDialog("Ennemy")

func inputManagement():
	var Direction = Vector2(0,0)
	if(Input.is_action_pressed("up")):
		Direction.y = -1
		get_node("AnimatedSprite").play("Back")
	elif(Input.is_action_pressed("down")):
		Direction.y = 1
		get_node("AnimatedSprite").play("Front")
	if(Input.is_action_pressed("left")):
		Direction.x = -1
		get_node("AnimatedSprite").play("Left")
	elif(Input.is_action_pressed("right")):
		Direction.x = 1
		get_node("AnimatedSprite").play("Right")
	else:
		get_node("AnimatedSprite").stop()
	if(Input.is_action_just_pressed("shoot")):
		var projectile = RedProjectile.instance()
		get_parent().add_child(projectile)
		projectile.position = position
		var angle = getAngle()
		projectile.setDirection(Vector2(cos(angle),sin(angle)))
	move_and_collide(Direction * SPEED)

func Hurt(amount):
	get_node("HealthBar").removeHealth(amount)

func getAngle():
	var CrosshairDistance = get_global_mouse_position() - position
	if(CrosshairDistance.x >= 0):
		return atan(CrosshairDistance.y/CrosshairDistance.x)
	else:
		return atan(CrosshairDistance.y/CrosshairDistance.x) + PI

func noHealth():
	get_tree().change_scene_to(GameOverScene)
