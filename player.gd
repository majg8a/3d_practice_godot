class_name Player extends CharacterBody3D
const SPEED = 5.0
const ACCELERATION = 10;
const ROTATION_SPEED = 10.0;
const JUMP_VELOCITY = 5.0;
const JUMP_STOCK = 10;
var jumps_spended = 0;
@export var gravity = -10;
@onready var pivot: Node3D = $Node3D;
@onready var rayCast: RayCast3D = $RayCast3D;

func _ready():
	Input.mouse_mode =  Input.MOUSE_MODE_CAPTURED

#camera angle
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x *.5))
		pivot.rotate_x(deg_to_rad(-event.relative.y * .5))
		pivot.rotation.x = clamp(pivot.rotation.x, deg_to_rad(-90), deg_to_rad(45))
		rayCast.rotation.x = pivot.rotation.x
		
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit();
	
	if Input.is_action_just_pressed("ui_select") and (is_on_floor() || jumps_spended < JUMP_STOCK):
		velocity.y = JUMP_VELOCITY;
		jumps_spended+=1;
	
	if jumps_spended > JUMP_STOCK:
		jumps_spended = 0;
	var direction =  Vector3.ZERO

	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	direction.z = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	#player movement by camera rotation
	direction = direction.rotated(Vector3.UP,rotation.y).normalized()
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		print(rayCast.get_collision_point().normalized())
		direction = rayCast.get_collision_point().normalized();
	
	velocity.y += gravity * delta
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	move_and_slide()

