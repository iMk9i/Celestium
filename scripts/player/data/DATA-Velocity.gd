extends EtyData; class_name PlayerVelocity


### - VARIABLES - ###


var velocity :Vector3

var max_speed :float= 100

## For moving via the ground or air taken by the player_inputs
var input :Vector3
var input_drag :float= 6.5

## For moving via constant outer forces aka Gravity, magnetic forces, etc
var force :Vector3

## For moving via single-frame forces aka boosts and dashes
var impulse :Vector3
var impulse_drag :float= 6.0


### - FUNCTIONS - ###


func update(delta:float) -> void:
	input = input.lerp(Vector3.ZERO, input_drag*delta)
	impulse = impulse.lerp(Vector3.ZERO, impulse_drag*delta)
	velocity = (input + force + impulse)
	
	ClampVelocity()


func add_input(i:Vector3) -> void:
	input += i


func add_force(f:Vector3, delta:float) -> void:
	force += (f*player.attributes["mass"])*delta


func add_impulse(i:Vector3) -> void:
	impulse += i


func ClampVelocity() -> void:
	if velocity.length() > max_speed: 
		velocity = velocity.normalized() * max_speed


func ClearInputs() -> void: 
	input = Vector3.ZERO
	force = Vector3.ZERO


func PrintResults() -> void:
	print("Velocity:")
	print("--|Input:",input)
	print("--|Force:",force)
	print("--|Impulse:",impulse)
