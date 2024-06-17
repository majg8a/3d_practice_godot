class_name Enemy_behavior

var newDirections = Direction.PLANE_DIRECTIONS().duplicate()

func linear_follow(enemy: Node3D,target: Node3D)-> Vector3:
	var targetPosition: Vector3 = Vector3(target.position)
	targetPosition.y = 0
	return (targetPosition - enemy.position).normalized()

var currentIteration: int = 0
var currentDirection = Vector3.ZERO
func roaming(repeat)-> Vector3:
	newDirections.shuffle()
	if(newDirections.size() == 0):
		newDirections = Direction.PLANE_DIRECTIONS().duplicate()
	if(repeat == currentIteration || currentIteration == 0):
		currentDirection = newDirections.pop_back()
		currentIteration = repeat
	currentIteration-=1
	return currentDirection
