extends Node; class_name EtySystem


var entity :Entity
var player :Player

@export var active :bool= true


func setup(e:Entity=null):
	entity=e
	if (e is Player): player = e


func update(delta):
	pass
