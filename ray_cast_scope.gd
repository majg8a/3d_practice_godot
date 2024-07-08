extends RayCast3D
@onready var endContainer: Node3D = $Node3D;
func _physics_process(delta):
	endContainer.global_position = get_collision_point()
