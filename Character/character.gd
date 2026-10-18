class_name Character
extends CharacterBody2D

@export var speed:int
@export var jump_speed:int
@export var gravity_aceleration:int 
@export var actual_velocity_y:int 
@export var jumps_left:int

func _physics_process(delta: float) -> void:
	jump()
	move()
	actual_velocity_y = velocity.y
	
	if not is_on_floor():
		velocity.y += gravity_aceleration * delta
		
	if position.y > 2000:
		position.y = -100
		velocity.y = gravity_aceleration
		
func jump():
	var jump_pressed = Input.is_action_just_pressed("Jump")
	
	if is_on_floor():
		jumps_left = 2
		
	if jump_pressed and jumps_left > 0:
		velocity.y = 0
		velocity.y -= jump_speed 
		jumps_left -= 1
		
func move():
	var direction = Input.get_axis("Left", "Right")
	velocity.x = speed * direction
	move_and_slide()
