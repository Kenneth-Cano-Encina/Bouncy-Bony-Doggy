class_name GameManager
extends Node

@onready var global_timer: Timer = $Global_timer
@onready var game_manager: Node = $"."

var total_gems:int = 0
var global_time:int

#region DEBUG
#=========================================================
var stop #DEBUG
var advance_time #DEBUG
#=========================================================
#endregion

func _ready() -> void:
	pass
func _process(delta: float) -> void:
	#region DEBUG
	stop  = Input.is_action_pressed("Stop_moving_debug") 
	advance_time = Input.is_action_just_pressed("Advance_time_DEBUG")
	
	if stop:
		global_timer.stop()
		
	elif not stop and global_timer.is_stopped():
		global_timer.start()
		
	if advance_time:
		advance_time_DEBUG()
		
	#endregion DEBUG
	
func collect_gem():
	total_gems += 1
	#print_rich("[color=green][b]GEMA RECOLLECTADA[/b][/color]")
	
func _on_global_timer_timeout() -> void:
	global_time += 1
	print_rich("[color=gray][b]",global_time,"[/b][/color]")
	
func advance_time_DEBUG():
	global_time += 10
	print_rich("[color=red][b]GLOBAL TIME ADVANCED: ",global_time ,"[/b][/color]")
