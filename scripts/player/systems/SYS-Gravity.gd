extends EtySystem; class_name PlrGravitySystem


@export var velocity :PlayerVelocity
var gravity :float= 0
var gravity_delta :float= ProjectSettings.get_setting("physics/3d/default_gravity")


func update(delta):
	var mass = player.attributes["mass"]
	if (!player.is_on_floor()): gravity -= (gravity_delta*mass)*delta
	elif (player.is_on_floor()): gravity = 0
	gravity = min(gravity, (mass*mass)*gravity_delta)
	
	velocity.add_force(player.up_direction*(gravity), .1)
