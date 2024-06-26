class_name Player_ extends CharacterBody3D
const SPEED = 5.0
const ACCELERATION = 10;
const ROTATION_SPEED = 10.0;
const JUMP_VELOCITY = 5.0;

@export var gravity = -10;
@onready var pivot: Node3D = $Node3D;

func _ready():
	Input.mouse_mode =  Input.MOUSE_MODE_CAPTURED
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x *.5))
		pivot.rotate_x(deg_to_rad(-event.relative.y * .5))
		pivot.rotation.x = clamp(pivot.rotation.x, deg_to_rad(-90), deg_to_rad(45))
		

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit();
	
	if Input.is_action_just_pressed("ui_select") and is_on_floor():
		velocity.y = JUMP_VELOCITY;
	var direction =  Vector3.ZERO

	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.z = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	if direction != Vector3.ZERO:
		print("antes",direction)
	
	direction = direction.rotated(Vector3.UP,rotation.y).normalized()
	
	if direction != Vector3.ZERO:
		print("despues",direction)
	
	
	velocity.y += gravity * delta
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	
#	if direction != Vector3.ZERO:
#		var target_rotation = atan2(-direction.x,-direction.z)
#		rotation.y = lerp_angle(rotation.y,target_rotation,ROTATION_SPEED * delta)
	move_and_slide()

#func _process(delta):
#	pivot.position = position
	
	
