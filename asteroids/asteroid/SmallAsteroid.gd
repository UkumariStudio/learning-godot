extends "res://asteroid/Asteroid.gd"

func _ready():
	score_value = 100

func explode():
	if is_exploded:
		return

	is_exploded = true
	
	emit_signal("score_changed", score_value)
	
	get_parent().call_deferred("remove_child", self)
	queue_free()
