extends RigidBody2D

var medium_asteroid_scene = load("res://asteroid/MediumAsteroid.tscn")

var thrust = Vector2.ZERO
var max_speed = 0
var is_exploded = false
var score_value = 20

var random = RandomNumberGenerator.new()

signal score_changed

func _ready():
	random.randomize()
	var thrust_x = random.randi_range(-250, 250)
	var thrust_y = random.randi_range(-250, 250)
	thrust = Vector2(thrust_x, thrust_y)
	max_speed = random.randi_range(150, 650)
	
	var label = get_tree().get_root().get_node("AsteroidField/GUI/MarginContainer/HBoxContainer/VBoxContainer/Score")
	self.connect("score_changed", label, "update_score")

func _integrate_forces(state):
	gravity_scale = 0
	
	applied_force = thrust
	
	if abs(get_linear_velocity().x) > max_speed or abs(get_linear_velocity().y) > max_speed:
		var new_speed = get_linear_velocity().normalized()
		new_speed *= max_speed
		set_linear_velocity(new_speed)
		
func explode():
	if is_exploded:
		return

	is_exploded = true
	
	emit_signal("score_changed", score_value)
	
	_spawn_medium_asteroid()
	
	get_parent().call_deferred("remove_child", self)
	queue_free()

func _spawn_medium_asteroid():
	for i in range(2):
		var medium_asteroid = medium_asteroid_scene.instance()
		medium_asteroid.position = self.position
		get_parent().add_child(medium_asteroid)
