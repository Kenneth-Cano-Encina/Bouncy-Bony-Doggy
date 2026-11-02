class_name Platform
extends AnimatableBody2D
@onready var platform: Platform = $"."

@export var original_speed:int 
var game_manager:GameManager
var path:Vector2i
var velocity:float

#===========================================================
var detener:bool
#===========================================================

func _ready() -> void:
	path = Vector2i(-500, platform.position.y)
	game_manager = get_tree().get_first_node_in_group("GameManager")
	velocity = original_speed
	
func _physics_process(delta: float) -> void:
	#======================================================================
	var stop = Input.is_action_pressed("Stop_moving_debug")
	stop_moving_debug()
	#======================================================================
	if game_manager != null and not stop:
		if game_manager.global_time >= 30 \
		and game_manager.global_time < 60:
			velocity = original_speed * 1.5
			
		elif game_manager.global_time >= 60 \
		and game_manager.global_time < 120:
			velocity = original_speed * 2
			
		elif game_manager.global_time >= 90 \
		and game_manager.global_time < 120:
			velocity = original_speed * 2.5 
			
		elif game_manager.global_time >= 120 \
		and game_manager.global_time < 180:
			velocity = original_speed * 3
			
		elif game_manager.global_time >= 180:
			velocity = original_speed * 3.5 
			
	global_position = global_position.move_toward(path, velocity * delta)
	if position.x == path.x:
		queue_free()
		
		
		
#======================================================================
func stop_moving_debug(): #DEBUG FUNTION
	var stop = Input.is_action_pressed("Stop_moving_debug")
	if stop or detener:
		velocity = 0
		
	else:
		velocity = original_speed
#======================================================================
