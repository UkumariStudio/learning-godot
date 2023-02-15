extends Area2D

var speed = 750
var velocity = Vector2()

func start(pos, dir):
	rotation = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(rotation)

func _process(delta):
	self.position += velocity * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_Bullet_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if (body.is_in_group("asteroids")):
		body.call_deferred("explode")
		get_parent().call_deferred("remove_child", self)
		queue_free()

	if (body.is_in_group("ships")):
		body.call_deferred("destroy")
		get_parent().call_deferred("remove_child", self)
		queue_free()
