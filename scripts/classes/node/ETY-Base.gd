extends CharacterBody3D; class_name Entity

### - SIGNALS - ###


signal just_grounded


### - VARIABLES - ###


# - EXPORTS


#@export var stats := ETY_Stats.new()


# - CONSTANTS

const AIR_FRICTION :float= 4
const GND_FRICTION :float= 12


# - VARIABLES

var was_on_floor :bool= false
var can_move :bool= true

## how fast the entity is moving generally
var spd :float
## how far the entity is rotated
var rot :float

## How heavy the entity is
var mass :float= 1
## the output for how fast the entity is moving in it's relative down direction
var g_velo :float
## how hard the gravity is affecting the entity 
var g_delta :float= 9.8
## where the entity is being gravitated towards
var g_point := Vector3.ZERO
## the direction where the entity is being gravitated towards : replaces the up_direction
var g_dir :Vector3= Vector3.UP

@export_subgroup("")
@export var g_lock :bool= true
@export var b_lock :bool= true


### - FUNCTIONS - ###


## For any entities that need to check if they just started touching the floor call "super._physics_process(...)"
func _physics_process(_delta: float) -> void:
	if is_on_floor() and !was_on_floor: just_grounded.emit()
	was_on_floor = is_on_floor()


## This is empty for custom movemnt scripting
func Movement(_delta:float) -> void: move_and_slide()


func ApplyRigidCollisions():
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider() is RigidBody3D:
			var rigid_body = collision.get_collider()
			
			rigid_body.apply_impulse(-collision.get_normal() * 1)


## Calculates the current gravity delta for the player and basis based on the g_point
## Needs to be called every physics frame
func CalcGravity() -> void:
	var delta = get_physics_process_delta_time()
	
	if (!is_on_floor()):
		g_velo = min(g_velo-((g_delta*mass) * delta), ((g_delta*mass)*mass))
	else: g_velo = 0
	if (g_lock): g_velo = 0
	
	g_dir = -global_position.direction_to(g_point) if (!b_lock) else g_dir.normalized()
	up_direction = lerp(up_direction, g_dir, 12*delta)
	
	basis.y = up_direction
	basis.x = basis.y.cross(basis.z)
	basis = basis.orthonormalized()
