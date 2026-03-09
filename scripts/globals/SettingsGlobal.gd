extends Node


var uSettings :UserSettings= preload("res://resources/configs/user settings/DefaultSettings.tres")


func _ready() -> void:
	#SetupKeybinds()
	pass


func SetupKeybinds():
	for a in InputMap.get_actions():
		InputMap.action_erase_events(a)
		
	InputMap.action_add_event("forward", uSettings.forward)
	InputMap.action_add_event("left", uSettings.left)
	InputMap.action_add_event("right", uSettings.right)
	InputMap.action_add_event("back", uSettings.back)
	InputMap.action_add_event("sprint", uSettings.sprint)
	InputMap.action_add_event("jump", uSettings.jump)
	
	InputMap.action_add_event("shoot", uSettings.shoot)
	InputMap.action_add_event("aim", uSettings.aim)
	InputMap.action_add_event("melee", uSettings.melee)
	
	InputMap.action_add_event("interact", uSettings.interact)
	
	InputMap.action_add_event("mouse_lock", uSettings.mouse_lock)
	
	InputMap.action_add_event("toggle_menu", uSettings.toggle_menu)
	InputMap.action_add_event("menu_return", uSettings.menu_return)
