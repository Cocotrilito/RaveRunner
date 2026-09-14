extends Area2D

const PROJECTILE =  preload("res://scenes/projectile.tscn")

func _shoot():
	var proj = PROJECTILE.instantiate()
	get_tree().current_scene.add_child(proj)
	proj.global_position = global_position
	proj.direction = Vector2.LEFT

func _on_attack():
	$AnimatedTelegraph.play("telegraph")
	await get_tree().create_timer(0.4).timeout
	_shoot()

func _ready():
	$AttackTimer.timeout.connect(_on_attack)
	
