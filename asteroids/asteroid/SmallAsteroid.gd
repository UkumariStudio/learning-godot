extends "res://asteroid/Asteroid.gd"

func explode():
	if is_exploded:
		return

	is_exploded = true
	
	get_parent().call_deferred("remove_child", self)
	queue_free()
