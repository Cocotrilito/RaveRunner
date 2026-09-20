extends Area2D

var direction = Vector2.LEFT
const SPEED = 500.0
var parried = false
var source_enemy = null

func _ready():
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)

func _physics_process(delta):
	position += direction * SPEED * delta
	

func _on_body_entered(body):
	if body.name == "Player" and not parried:
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
	if source_enemy and is_instance_valid(source_enemy):
		source_enemy.stop_attacking()
