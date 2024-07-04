class_name Behavior


func linear_follow(enemy: Node3D,target: Node3D)-> Vector3:
	var targetPosition: Vector3 = Vector3(target.position)
	targetPosition.y = 0
	return (targetPosition - enemy.position).normalized()

var currentIteration: int = 0
var currentDirection = Vector3.ZERO
var newDirections: Array[Vector3] = []
func roaming(repeat: int, directions: Array[Vector3])-> Vector3:
	if(newDirections.size() == 0):
		newDirections = directions.duplicate()
	if(repeat == currentIteration || currentIteration == 0):
		currentDirection = newDirections.pop_back()
		currentIteration = repeat
	currentIteration-=1
	return currentDirection
