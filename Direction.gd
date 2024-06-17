class_name Direction

const PLANE_BASIC_DIRECTIONS: Array[Vector3] =  [
		Vector3.FORWARD,
		Vector3.BACK,
		Vector3.LEFT,
		Vector3.RIGHT
	]

static func PLANE_DIRECTIONS(): 
	var newDirections: Array[Vector3] = PLANE_BASIC_DIRECTIONS.duplicate()
	newDirections.push_back((newDirections[0] + newDirections[2]).normalized())
	newDirections.push_back((newDirections[0] + newDirections[3]).normalized())
	newDirections.push_back((newDirections[1] + newDirections[2]).normalized())
	newDirections.push_back((newDirections[1] + newDirections[3]).normalized())
	return newDirections
