class_name Enemy
extends Area2D

signal selected


func _on_Enemy_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		var e := event as InputEventMouseButton
		if e.pressed:
			emit_signal("selected")
