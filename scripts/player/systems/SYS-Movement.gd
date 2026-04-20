extends EtySystem; class_name PlrMoveSystem


var move_state :MOVE_STATE
enum MOVE_STATE {GROUNDED,AERIAL,BOOSTING,STUNNED}
var is_hovering :bool= false

var jump_cost :float= -1
var boost_cost :float= -2

var speed_add :Array[float]= []

var direction :Vector3

@export var velocity :VelocityData
@export var gravity :PlrGravitySystem


func update(delta):
	
	var spd_add :float= 0
	for s in speed_add: spd_add += s
	
	var input = player.player_inputs["input"]
	var speed = player.attributes["speed"]+spd_add
	var mass = player.attributes["mass"]
	var lift_str = player.attributes["lift_str"]-mass
	var jump_str = player.attributes["jump_str"]
	var boost_str = player.attributes["boost_str"]
	
	### INPUT PROCESSING
	direction += Vector3(input.x, 0, input.y)
	velocity.add_input( player.LocalizeVector(direction*speed)*delta )
