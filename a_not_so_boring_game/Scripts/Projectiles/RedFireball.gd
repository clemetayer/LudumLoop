extends Area2D

export var SPEED = 10
export var DAMAGE = 5

var Direction = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setDirection(Angle):
	Direction = Angle

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	translate(Direction * SPEED)

func _on_RedFireball_body_entered(body):
	if(body.is_in_group("Ennemy")):
		body.Hurt(DAMAGE)
		queue_free()
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
