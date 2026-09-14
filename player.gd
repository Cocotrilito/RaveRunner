extends CharacterBody2D

const SPEED = 300.0
const GRAVITY = 1200.0
var gravity_direction = 1
const FLIP_IMPULSE = 700.0

func _on_flip():
	var tween = create_tween()
	tween.tween_property($Sprite2D, "scale", Vector2(0.7, 1.3), 0.05)
	tween.tween_property($Sprite2D, "scale", Vector2(1,1), 0.1)

func _physics_process(delta):
	velocity.y += GRAVITY * gravity_direction * delta
	velocity.x = SPEED
	
	
	
	if is_on_floor() or is_on_ceiling():
		if Input.is_action_just_pressed("move_up"):
			_on_flip()
			gravity_direction = -1
			velocity.y = -FLIP_IMPULSE
		elif Input.is_action_just_pressed("move_down"):
			_on_flip()
			gravity_direction = 1
			velocity.y = FLIP_IMPULSE
	move_and_slide()
