extends Marker3D
@onready var player = get_node("../player")
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _physics_process(delta):
	position = player.position

#func _input(e):
#	if e is InputEventMouseMotion:
#		var mousePosition = e.relative
#		rotate_object_local(Vector3.DOWN, mousePosition.x  * .001)
#		rotate_object_local(Vector3.LEFT, mousePosition.y  * .001)
