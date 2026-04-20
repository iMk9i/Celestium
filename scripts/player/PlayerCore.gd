extends Entity; class_name Player


### - SIGNALS - ###


signal just_grounded


### - VARIABLES - ###


var player_inputs :Dictionary[String, Variant]
@export var ground_ray :RayCast3D
@export var veloData :PlayerVelocity

var was_on_floor :bool= false
var grounded :bool= false


### - FUNCTIONS - ###


func _ready() -> void:
	for sys in $Systems.get_children():
		if sys is EtySystem: sys.setup(self)
	for dat in $Data.get_children():
		if dat is EtyData: dat.setup(self)


func _physics_process(delta: float) -> void:
	grounded = ground_ray.is_colliding()
	if grounded and !was_on_floor: just_grounded.emit()
	was_on_floor = grounded
	CalcBasis()
	
	player_inputs = {
		"input":Input.get_vector("left", "right", "forward", "backward").normalized(),
		"jump":Input.is_action_just_pressed("jump"),
		"hover":Input.is_action_pressed("jump"),
		"drop":Input.is_action_just_pressed("descent"),
		"boost":Input.is_action_just_pressed("dash"),
		"sprint":Input.is_action_pressed("dash"),
	}
	#veloData.PrintResults()
	veloData.ClearInputs()
	
	for sys in $Systems.get_children():
		if sys is EtySystem: if (sys.active): sys.update(delta)
	
	veloData.update(delta)
	velocity = veloData.velocity
	
	move_and_slide()
