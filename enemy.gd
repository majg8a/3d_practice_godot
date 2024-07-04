extends CharacterBody3D
const SPEED = 2.0

const ACCELERATION = 10;
const ROTATION_SPEED = 10.0;
const JUMP_VELOCITY = 5.0;

var target: CharacterBody3D = null
var gravity = -10;
var targetName = "player";

@onready var detectionArea: Area3D = $detectionArea

var currentBehavior = BEHAVIOR.ROAMING
var behavior = Behavior.new()

func _ready():
	detectionArea.body_entered.connect(targetDetection)
	detectionArea.body_exited.connect(targetLost)

func _physics_process(delta):

	var direction =  Vector3.ZERO
	match currentBehavior:
		BEHAVIOR.ROAMING:
			var directionSet = Direction.PLANE_DIRECTIONS()
			directionSet.shuffle()
			direction = behavior.roaming(round(randf_range(20,30)),directionSet)
		BEHAVIOR.FOLLOWING:
			direction = behavior.linear_follow(self,target)
	
	velocity.y += gravity * delta
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	
	if direction != Vector3.ZERO:
		var target_rotation = atan2(-direction.x,-direction.z)
		rotation.y = lerp_angle(rotation.y,target_rotation,ROTATION_SPEED * delta)
	move_and_slide()
	
	if !is_on_floor():
		self.queue_free()

func targetDetection(body: Node3D):
	if (is_instance_of(body,Player_)):
		target = body
		currentBehavior = BEHAVIOR.FOLLOWING
		
func targetLost(body):
	if(body == target):
		target = null
		currentBehavior = BEHAVIOR.ROAMING
		
