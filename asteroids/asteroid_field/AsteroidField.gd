extends Node2D

var asteroid = preload("res://asteroid/Asteroid.tscn")
var ufo = preload("res://ufo/UFO.tscn")
var player = preload("res://player/Player.tscn")

var rand_x = 0
var rand_y = 0
var level_initial_asteroids = 4
var range_seed = 100

var random = RandomNumberGenerator.new()
var ufo_timer = Timer.new()

func _ready():
	random.randomize()
	
	spawn_player()
	spawn_asteroids()
	
	ufo_timer.connect("timeout", self, "spawn_ufo")
	ufo_timer.wait_time = 30
	add_child(ufo_timer)
	ufo_timer.start()
	
	print("asteroids: ", level_initial_asteroids)
	
func spawn_player():
	var p = player.instance()
	p.global_position = Vector2(640, 360)
	add_child(p)
	
func spawn_asteroids():
	for i in range(level_initial_asteroids):
		var a = asteroid.instance()
		rand_x = random.randi_range(0, 1280)
		rand_y = random.randi_range(0, 720)
		a.global_position = Vector2(rand_x, rand_y)
		add_child(a)

func spawn_ufo():
	print("spawn_ufo")
	var u = ufo.instance()
	
	rand_x = random.randi_range(-range_seed, range_seed)
	rand_y = random.randi_range(-range_seed, range_seed)
	u.global_position = Vector2(rand_x, rand_y)
	add_child(u)

func _process(delta):
	var asteroids = get_tree().get_nodes_in_group("asteroids")
	if asteroids.size() == 0 and level_initial_asteroids < 12:
		level_initial_asteroids += 2
		spawn_asteroids()
		print("asteroids: ", level_initial_asteroids)
