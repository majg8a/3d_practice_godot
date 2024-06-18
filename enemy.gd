extends CharacterBody3D
const SPEED = 2.0

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
var behavior: Behavior = Behavior.new()

func _ready():
	detectionArea.body_entered.connect(targetDetection)
	detectionArea.body_exited.connect(targetLost)

func _physics_process(delta):
	var direction =  Vector3.ZERO
	match currentBehavior:
		BEHAVIOR.ROAMING:
			direction = behavior.roaming(30)
		BEHAVIOR.FOLLOWING:
			direction = behavior.linear_follow(self,target)
	
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
		
