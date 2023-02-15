extends "res://asteroid/Asteroid.gd"

var small_asteroid_scene = load("res://asteroid/SmallAsteroid.tscn")

func _ready():
	score_value = 50

func explode():
	if is_exploded:
		return

	is_exploded = true
	
	emit_signal("score_changed", score_value)
	
	_spawn_small_asteroid()
	
	get_parent().call_deferred("remove_child", self)
	queue_free()

func _spawn_small_asteroid():
	for i in range(2):
		var small_asteroid = small_asteroid_scene.instance()
		small_asteroid.position = self.position
		get_parent().add_child(small_asteroid)
