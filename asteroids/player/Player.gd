extends KinematicBody2D

export (int) var speed = 300
export (float) var rotation_speed = 5.0

const Bullet = preload("res://bullet/Bullet.tscn")

var velocity = Vector2()
var rotation_dir = 0
var is_destroyed = false

var random = RandomNumberGenerator.new()

func _ready():
	random.randomize()

func get_input():
	rotation_dir = 0
	velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		rotation_dir += 1
	if Input.is_action_pressed("ui_left"):
		rotation_dir -= 1
	if Input.is_action_pressed("ui_up"):
		velocity = Vector2(speed, 0).rotated(rotation)
	if Input.is_action_pressed("ui_down"):
		jump()
	if Input.is_action_just_pressed("ui_select"):
		shoot()
		
func shoot():
	var b = Bullet.instance()
	b.start($Muzzle.global_position, rotation)
	get_parent().add_child(b)
	
func destroy():
	if is_destroyed:
		return

	is_destroyed = true
	
	get_parent().call_deferred("remove_child", self)
	queue_free()
	
func jump():
	var pos_x = random.randi_range(0, 1280)
	var pos_y = random.randi_range(0, 720)
	position = Vector2(pos_x, pos_y)

func _physics_process(delta):
	get_input()
	rotation += rotation_dir * rotation_speed * delta
	move_and_collide(velocity * delta)
	
func _on_Hitbox_body_entered(body):
	if (!self.is_queued_for_deletion() && body.is_in_group("asteroids")):
		destroy()
