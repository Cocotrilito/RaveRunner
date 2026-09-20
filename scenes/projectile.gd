extends Area2D

var direction = Vector2.LEFT
const BASE_SPEED = 500.0
const PARRY_SPEED_BOOST = 3.0
var  current_speed = BASE_SPEED
var parried = false
var source_enemy = null

func _ready():
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)

func _physics_process(delta):
	position += direction * current_speed * delta
	

func _on_body_entered(body):
	if body.name == "Player" and not parried:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -20)
		get_tree().change_scene_to_file("res://scenes/death_screen.tscn")

func _on_area_entered(area):
	if area.is_in_group("enemy") and parried:
		area.queue_free()
		queue_free()

# the goat
func do_parry():
	if parried:
		return
	parried = true
	direction *= -1
	current_speed = BASE_SPEED * PARRY_SPEED_BOOST
	if source_enemy and is_instance_valid(source_enemy):
		source_enemy.stop_attacking()
