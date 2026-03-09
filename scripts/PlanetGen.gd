@tool extends MeshInstance3D


@warning_ignore("unused_private_class_variable")
@export_tool_button("Create Mesh") var _cm = CreateMesh

@export var ICW :IcoWorldGen


func CreateMesh() -> void:
	ICW.CreateMesh()
	mesh = ICW.mesh
