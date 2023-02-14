extends Node2D

var asteroid = preload("res://asteroid/Asteroid.tscn")
var ufo = preload("res://ufo/UFO.tscn")
var rand_x = 0
var rand_y = 0
var level_initial_asteroids = 4
var range_seed = 100

var random = RandomNumberGenerator.new()

func _ready():
	random.randomize()
	for i in range(level_initial_asteroids):
		var a = asteroid.instance()
	
		rand_x = random.randi_range(-range_seed, range_seed)
		rand_y = random.randi_range(-range_seed, range_seed)
		a.global_position = Vector2(rand_x, rand_y)
	
		add_child(a)
	
	var u = ufo.instance()
	
	rand_x = random.randi_range(-range_seed, range_seed)
	rand_y = random.randi_range(-range_seed, range_seed)
	u.global_position = Vector2(rand_x, rand_y)
	add_child(u)
