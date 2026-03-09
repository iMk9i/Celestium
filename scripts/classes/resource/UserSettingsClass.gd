extends Resource; class_name UserSettings

@export_group("Mouse Settings")
@export var sensitivity := Vector2(1,1)
@export var aim_sensitivity := Vector2(1,1)
@export var sensitivity_smooth :float= 12

@export_group("Keybids")
@export var forward :InputEvent
@export var left :InputEvent
@export var right :InputEvent
@export var back :InputEvent
@export var sprint :InputEvent
@export var jump :InputEvent


@export var shoot :InputEvent
@export var aim :InputEvent
@export var melee :InputEvent


@export var interact :InputEvent

@export var mouse_lock :InputEventKey

@export_subgroup("Menu Keys")
@export var toggle_menu :InputEventKey
@export var menu_return :InputEvent
