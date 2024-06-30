class_name Direction

const PLANE_BASIC_DIRECTIONS: Array[Vector3] =  [
		Vector3.FORWARD,
		Vector3.RIGHT,
		Vector3.BACK,
		Vector3.LEFT
	]

static func PLANE_DIRECTIONS()-> Array[Vector3]: 
	return  [
		Vector3.FORWARD,
		Vector3(1,0,-1).normalized(),
		Vector3.RIGHT,
		Vector3(1,0,1).normalized(),
		Vector3.BACK,
		Vector3(-1,0,1).normalized(),		
		Vector3.LEFT,
		Vector3(-1,0,-1).normalized(),
	]
