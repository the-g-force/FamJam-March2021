extends Control

export var main_menu_scene :PackedScene 


func _input(event:InputEvent)->void:
	if event is InputEventMouseButton and event.is_pressed():
		var _ignore = get_tree().change_scene_to(main_menu_scene)
