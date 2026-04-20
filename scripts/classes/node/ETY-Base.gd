extends CharacterBody3D; class_name Entity

### - SIGNALS - ###


### - VARIABLES - ###


# - VARIABLES

## how far the entity is rotated
var rot :float
## where the entity is being gravitated towards
var g_point := Vector3.ZERO
## the direction where the entity is being gravitated towards : replaces the up_direction
var g_dir :Vector3= Vector3.UP

@export_subgroup("")
@export var lock_basis :bool= true
@export var attributes :Dictionary[String, float]


### - FUNCTIONS - ###


func ApplyRigidCollisions():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider() is RigidBody3D:
			var rigid_body = collision.get_collider()
			
			rigid_body.apply_impulse(-collision.get_normal() * 1)


func LocalizeVector(input:Vector3) -> Vector3:
	return (basis.x*input.x)+(basis.y*input.y)+(basis.z*input.z)


## Calculates the current basis rotation based on the g_point
## Needs to be called every physics frame
func CalcBasis() -> void:
	var delta = get_physics_process_delta_time()
	
	g_dir = -global_position.direction_to(g_point) if (!lock_basis) else g_dir.normalized()
	up_direction = lerp(up_direction, g_dir, 12*delta)
	
	basis.y = up_direction
	basis.x = basis.y.cross(basis.z)
	basis = basis.orthonormalized()
