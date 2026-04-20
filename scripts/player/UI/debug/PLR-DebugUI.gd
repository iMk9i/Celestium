extends EtySystem; class_name PlrDebugUI


@export var energybar :TextureProgressBar
@export var healthbar :TextureProgressBar

@export var datinfo :Label
@export var veda :VelocityData

@export var sysinfo :Label
@export var mvsi :PlrMoveSystem
@export var grsi :PlrGravitySystem


func _ready() -> void:
	player = get_parent().get_parent()
	energybar.max_value = player.attributes["energy_max"]


func _physics_process(delta: float) -> void:
	energybar.value = player.attributes["energy"]
	
	datinfo.text = "
	Velocity : {vl}
	-|Input : {in}
	-|Force : {fr}
	-|Impact : {im}
	
	Energy : {en}".format({
		"vl":int(player.velocity.length()),
		"in":Vector3i(veda.input),
		"fr":Vector3i(veda.force),
		"im":Vector3i(veda.impulse),
		"en":player.attributes["energy"],
	})
	sysinfo.text = "
	
	MOVEMENT:
	-|DIRECTION : {mvdr}
	-|STATE : {mvst}
	-|HOVERING : {mvhv}
	
	GRAVITY : 
	-|VALUE : {grva}
	-|DELTA : {grdt}".format({
		"mvdr":Vector3i(mvsi.direction),
		"mvst":mvsi.move_state,
		"mvhv":mvsi.is_hovering,
		"grva":int(grsi.gravity),
		"grdt":grsi.gravity_delta,
	})
