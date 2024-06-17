extends CharacterBody3D
const SPEED = 5.0
const ACCELERATION = 10;
const ROTATION_SPEED = 10.0;
const JUMP_VELOCITY = 5.0;

@export var gravity = -10;

#const input_directions = {
#	"ui_left": Vector3.LEFT,
#	"ui_right": Vector3.RIGHT,
#	"ui_up": Vector3.FORWARD,
#	"ui_down": Vector3.BACK
#}

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_select") and is_on_floor():
		velocity.y = JUMP_VELOCITY;
	var direction =  Vector3.ZERO
#	for key in input_directions.keys():
#		if Input.is_action_pressed(key):
#			direction += input_directions.get(key)
#			direction = direction.normalized()
#			velocity.x = direction.x * SPEED
#			velocity.z = direction.z * SPEED
#	if direction == Vector3.ZERO:
#		velocity.z = 0
#		velocity.x = 0
	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.z = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	velocity.y += gravity * delta
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	
	if direction != Vector3.ZERO:
		var target_rotation = atan2(-direction.x,-direction.z)
		rotation.y = lerp_angle(rotation.y,target_rotation,ROTATION_SPEED * delta)
	move_and_slide()


