extends Area2D



@onready var attack: Sprite2D = $Attack
@onready var idle: Sprite2D = $idle


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
	idle.visible = false
	attack.visible = true
	await get_tree().create_timer(0.4).timeout
	attack.visible = false
	idle.visible = true
	_shoot()
	
	

func _ready():
	add_to_group("enemy")
	$AttackTimer.timeout.connect(_on_attack)
	


func _on_visible_on_screen_notifier_2d_screen_entered():
	$AttackTimer.start()

func _on_visible_on_screen_notifier_2d_screen_exited():
	$AttackTimer.stop()
