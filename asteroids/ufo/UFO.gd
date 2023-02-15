extends KinematicBody2D

const Bullet = preload("res://bullet/Bullet.tscn")

var random = RandomNumberGenerator.new()
var timer_dir = Timer.new()
var timer_shoot = Timer.new()
var life_span = Timer.new()

export (int) var speed = 300
export (float) var rotation_speed = 5.0
var velocity = Vector2()
var rotation_dir = 0
var range_seed = 100
var is_destroyed = false
var score_value = 200

signal score_changed

func _ready():
	random.randomize()
	rotation_dir = random.randi_range(-range_seed, range_seed)
	
	timer_dir.connect("timeout", self, "change_dir")
	timer_dir.wait_time = 10
	add_child(timer_dir)
	timer_dir.start()
	
	timer_shoot.connect("timeout", self, "shoot")
	timer_shoot.wait_time = 0.3
	add_child(timer_shoot)
	timer_shoot.start()
	
	life_span.connect("timeout", self, "remove_ufo")
	life_span.wait_time = 60
	life_span.one_shot = true
	add_child(life_span)
	life_span.start()
	
	var label = get_tree().get_root().get_node("AsteroidField/GUI/MarginContainer/HBoxContainer/VBoxContainer/Score")
	self.connect("score_changed", label, "update_score")
	
func change_dir():
	rotation_dir = random.randi_range(-range_seed, range_seed)

func shoot():
	var b = Bullet.instance()
	b.start($Muzzle.global_position, rotation)
	get_parent().add_child(b)
	
func remove_ufo():
	queue_free()
	
func destroy():
	if is_destroyed:
		return

	is_destroyed = true
	
	emit_signal("score_changed", score_value)
	
	get_parent().call_deferred("remove_child", self)
	remove_ufo()

func _physics_process(delta):
	rotation += rotation_dir * rotation_speed * delta
	velocity = Vector2(speed, 0).rotated(rotation)
	move_and_collide(velocity * delta)
	rotation_dir = 0
