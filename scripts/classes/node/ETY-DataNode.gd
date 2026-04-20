extends Node; class_name EtyData


var entity :Entity
var player :Player


func setup(e:Entity=null):
	entity=e
	if (e is Player): player = e
