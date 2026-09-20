extends Area2D

const PROJECTILE =  preload("res://scenes/projectile.tscn")

func _shoot():
	var proj = PROJECTILE.instantiate()
	get_tree().current_scene.add_child(proj)
	proj.global_position = global_position
	proj.direction = Vector2.LEFT
	proj.source_enemy = self

func stop_attacking():
	$AttackTimer.stop()
	
func _on_attack():
	$Sprite2D.modulate = Color.RED
	# $AnimatedTelegraph.play("telegraph") LUEGO
	await get_tree().create_timer(0.4).timeout
	$Sprite2D.modulate = Color.WHITE
	_shoot()

func _ready():
	add_to_group("enemy")
	$AttackTimer.timeout.connect(_on_attack)
	
