class_name Enemy_behavior

const PLANE_DIRECTIONS =  [
		Vector3.FORWARD,
		Vector3.BACK,
		Vector3.LEFT,
		Vector3.RIGHT
	]


static func linear_follow(enemy: Node3D,target: Node3D)-> Vector3:
	var targetPosition: Vector3 = Vector3(target.position)
	targetPosition.y = 0
	return (targetPosition - enemy.position).normalized()
	
static func roaming(enemy)-> Vector3:
	var newDirections = Array(PLANE_DIRECTIONS)
	newDirections.shuffle()
	return newDirections[0]
	
