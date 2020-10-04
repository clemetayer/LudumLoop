extends KinematicBody2D

export var MIN_SPEED = 1
export var MAX_SPEED = 3
export var MAX_WAIT_TIME = 1

export var DIALOG = []

var PurpleProjectile = preload("res://Scenes/Projectiles/PurpleFireball.tscn")
var TrueWinScene = preload("res://Scenes/GameScenes/TrueWinScreen.tscn")

var speed = MIN_SPEED

var dialogDone = false
var canTalk = false
var dialogPagePrinting = false
var dialogPage = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	canTalk = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(dialogDone):
		var angleToPlayer = getAngle()
		var direction = Vector2(cos(angleToPlayer), sin(angleToPlayer))
		translate(direction * speed)
		playAnimation(angleToPlayer)
	elif(canTalk):
		var dialogBox = get_node("DialogBox")
		if(not dialogBox.StartDialog and not dialogPagePrinting): #Dialog not started
			dialogBox.dialog = DIALOG[dialogPage]
			dialogBox.StartDialog()
			dialogPagePrinting = true
		elif(not dialogBox.StartDialog and dialogPagePrinting): #Dialog done
			dialogPagePrinting = false
			if(dialogPage == 4):
				dialogDone = true
				canTalk = false
				get_parent().dialogDone()
				get_node("ShootTimer").start()
			else:
				canTalk = false
				dialogPage += 1
				get_parent().nextDialog("Player")


func getAngle():
	var PlayerDistance = get_parent().getPlayerPosition() - position
	if(PlayerDistance.x == 0):
		return 0
	elif(PlayerDistance.x > 0):
		return atan(PlayerDistance.y/PlayerDistance.x)
	else:
		return atan(PlayerDistance.y/PlayerDistance.x) + PI

func playAnimation(angle):
	if(abs(cos(angle)) >= abs(sin(angle))):
		if(cos(angle) <= 0):
			get_node("AnimatedSprite").play("Left")
		else:
			get_node("AnimatedSprite").play("Right")
	else:
		if(sin(angle) <= 0):
			get_node("AnimatedSprite").play("Back")
		else:
			get_node("AnimatedSprite").play("Front")

func Hurt(amount):
	get_node("HealthBar").removeHealth(amount)
	speed = (MIN_SPEED + ((MAX_SPEED - MIN_SPEED)*(1-(get_node("HealthBar").HEALTH/100.0))))

func noHealth():
	get_tree().change_scene_to(TrueWinScene)

func _on_ShootTimer_timeout():
	var projectile = PurpleProjectile.instance()
	get_parent().add_child(projectile)
	projectile.position = position
	var angle = getAngle()
	projectile.setDirection(Vector2(cos(angle),sin(angle)))
	get_node("ShootTimer").set_wait_time(MAX_WAIT_TIME * (get_node("HealthBar").HEALTH/100.0))
	get_node("ShootTimer").start()
