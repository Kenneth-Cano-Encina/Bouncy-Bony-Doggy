class_name Platform_spawner
extends Node2D

const PLATFORM_SCENE = preload("uid://c4g6j57r4g2l4")
const GEM_PLATFORM_SCENE = preload("uid://lg61magmqwfc")

@onready var spawn_cooldown: Timer = $Spawn_cooldown
@onready var platform_spawner: Node2D = $"."

var platform:Platform = PLATFORM_SCENE.instantiate() as Platform
var gem_platform:Platform = GEM_PLATFORM_SCENE.instantiate() as Platform

@export var max_distance_y_between_platforms:int = 260
@export var min_distance_y_between_platforms:int = 80

@export var max_distance_x_between_platform:int = 60
@export var min_distance_x_between_platform:int = -60


var last_position_y:Array[int] = []
var last_position_x:Array[int] = []

#========================================================== --DEBUG--
var stop
#========================================================== --DEBUG--

func _process(delta: float) -> void:
	#====================================================== --DEBUG--
	stop = Input.is_action_pressed("Stop_moving_debug")
	#====================================================== --DEBUG--
	if spawn_cooldown.is_stopped() and not stop:
		Spawn_random_platform()
		spawn_cooldown.start()
		
func spawn_platform(platform_type:Platform):
	var new_platform = platform_type.duplicate()
	var new_position_y = random_position_y(last_position_y)
	
	new_platform.position.y = new_position_y
	last_position_y.clear()
	last_position_y.append(new_position_y)
	
	var new_position_x = platform_spawner.position.x + random_position_x()
	new_platform.position.x =  new_position_x
	
	get_tree().current_scene.add_child(new_platform)
	
	
func Spawn_random_platform():
	var rng = RandomNumberGenerator.new()
	var probability = rng.randi_range(1, 4)
	
	if probability == 1:
		spawn_platform(gem_platform)
	else:
		spawn_platform(platform)
		
func random_position_y(last_position_y:Array[int]):
	var rng = RandomNumberGenerator.new()
	var random_position_y = rng.randi_range(80, 588)
	
	if last_position_y.is_empty():
		print_rich("[color=cyan][b]Last_position: ",last_position_y,"[/b][/color]")
		print_rich("[color=yellow][b]random_position_y: ",random_position_y,"[/b][/color]")
		return random_position_y
		
	else:
		while abs(random_position_y - last_position_y[0]) < min_distance_y_between_platforms \
		or abs(random_position_y - last_position_y[0]) > max_distance_y_between_platforms \
		or random_position_y < 80 \
		or random_position_y > 588:
			#print_rich("[color=orange][b]last_position_y: ",last_position,"[/b][/color]")
			#print_rich("[color=orange][b]random_position_y: ",random_position_y,"[/b][/color]")
			random_position_y = rng.randi_range((last_position_y[0] - max_distance_y_between_platforms), (last_position_y[0] + max_distance_y_between_platforms))
			
		#print_rich("[color=cyan][b]Last_position: ",last_position,"[/b][/color]")
		#print_rich("[color=yellow][b]random_position_y: ",random_position_y,"[/b][/color]")
		return random_position_y
		
func random_position_x():
	var rng = RandomNumberGenerator.new()
	var random_position_x = rng.randi_range(-20, 20)
	#print_rich("[color=red][b]",random_position_x,"[/b][/color]")
	#print_rich("[color=red][b]",platform_spawner.position.x,"[/b][/color]")
	return random_position_x
	
