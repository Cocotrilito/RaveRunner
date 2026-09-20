extends CharacterBody2D

const SPEED = 700.0
const GRAVITY = 1200.0
var gravity_direction = 1
const FLIP_IMPULSE = 700.0
var shake_tween: Tween


func _shake_camera():
	print("shakyshakyshaky")
	var cam = $Camera2D
	if shake_tween:
		shake_tween.kill()
	shake_tween = create_tween()
	shake_tween.tween_property(cam, "offset", Vector2(randf_range(-60,60), randf_range(-60,60)), 0.03)
	shake_tween.tween_property(cam, "offset", Vector2.ZERO, 0.05)
	
func _on_flip():
	_shake_camera()
	var tween = create_tween()
	tween.tween_property($Sprite2D, "scale", Vector2(0.7, 1.3), 0.05)
	tween.tween_property($Sprite2D, "scale", Vector2(1,1), 0.1)

func _on_land():
	_shake_camera()
	var tween = create_tween()
	tween.tween_property($Sprite2D, "scale", Vector2(1.3, 0.7), 0.05)
	tween.tween_property($Sprite2D, "scale", Vector2(1,1), 0.1)
	

func _physics_process(delta):
	
	var was_in_air = not (is_on_floor() or is_on_ceiling())
	
	velocity.y += GRAVITY * gravity_direction * delta
	velocity.x = SPEED
	
	
	
	if is_on_floor() or is_on_ceiling():
		if was_in_air:
			_on_land()
		if Input.is_action_just_pressed("move_up"):
			_on_flip()
			gravity_direction = -1
			velocity.y = -FLIP_IMPULSE
		elif Input.is_action_just_pressed("move_down"):
			_on_flip()
			gravity_direction = 1
			velocity.y = FLIP_IMPULSE
			
			
	move_and_slide()







func _on_parry_zone_area_entered(body):
		if body.has_method("do_parry") and Input.is_action_pressed("parry"):
			body.do_parry()
