extends CharacterBody3D
const SPEED = 5.0

const ACCELERATION = 10;
const ROTATION_SPEED = 10.0;
const JUMP_VELOCITY = 5.0;

var target: CharacterBody3D = null

@export var gravity = -10;
@export var targetName = "player";

@onready var detectionArea: Area3D = $detectionArea

enum BEHAVIOR {
	STATIONARY,
	ROAMING,
	FOLLOWING
}

var currentBehavior: BEHAVIOR = BEHAVIOR.ROAMING

func _ready():
	detectionArea.area_entered.connect(targetDetection)
	detectionArea.area_exited.connect(targetLost)

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
#	direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
#	direction.z = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")

	match currentBehavior:
		BEHAVIOR.ROAMING:
			direction = Enemy_behavior.roaming(self)
		BEHAVIOR.FOLLOWING:
			direction = Enemy_behavior.linear_follow(self,target)
	
	velocity.y += gravity * delta
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	
	if direction != Vector3.ZERO:
		var target_rotation = atan2(-direction.x,-direction.z)
		rotation.y = lerp_angle(rotation.y,target_rotation,ROTATION_SPEED * delta)
	move_and_slide()

func targetDetection(body: Node3D):
	if (body.name == targetName):
		target = body
		currentBehavior = BEHAVIOR.FOLLOWING
		
func targetLost(body):
	if(body == target):
		target = null
		currentBehavior = BEHAVIOR.ROAMING
		
