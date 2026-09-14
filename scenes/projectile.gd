extends Area2D

var direction = Vector2.LEFT
const SPEED = 500.0
var parried = false

func _ready():
	body_entered.connect(_on_body_entered)

func _physics_process(delta):
	position += direction * SPEED * delta
	

func _on_body_entered(body):
	if body.name == "Player" and not parried:
		body.queue_free()
	elif body.name == "Enemy" and parried:
		body.queue_free()
			

# the goat
func do_parry():
	parried = true
	direction *= -1
