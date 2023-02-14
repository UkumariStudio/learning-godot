extends KinematicBody2D

export (int) var speed = 300
export (float) var rotation_speed = 5.0

const Bullet = preload("res://bullet/Bullet.tscn")

var random = RandomNumberGenerator.new()
var timer_dir = Timer.new()
var timer_shoot = Timer.new()
var life_span = Timer.new()

var velocity = Vector2()
var rotation_dir = 0
var range_seed = 100

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
	
func change_dir():
	rotation_dir = random.randi_range(-range_seed, range_seed)

func shoot():
	var b = Bullet.instance()
	b.start($Muzzle.global_position, rotation)
	get_parent().add_child(b)
	
func remove_ufo():
	queue_free()

func _physics_process(delta):
	rotation += rotation_dir * rotation_speed * delta
	velocity = Vector2(speed, 0).rotated(rotation)
	move_and_collide(velocity * delta)
	rotation_dir = 0
