extends Control


func _input(event:InputEvent)->void:
	if event is InputEventMouseButton and event.is_pressed():
		var _ignore = get_tree().change_scene("res://src/Game.tscn")
