extends Node2D
const PLATFORM_SCENE = preload("uid://c4g6j57r4g2l4")
@onready var spawn_cooldown: Timer = $Spawn_cooldown
@onready var platform_generator: Node2D = $"."

var platform:Platform = PLATFORM_SCENE.instantiate() as Platform

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_child(platform)
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if spawn_cooldown.is_stopped():
		spawn_platform()
		spawn_cooldown.start()
		
func spawn_platform():
	var rng = RandomNumberGenerator.new() #ATTENTION Arreglar el problema de que la plataforma sea una sola entidad
	platform.position.y = rng.randi_range(0, 648)
	get_tree().current_scene.add_child(platform)
	
	
