extends Node2D

# The node to track toward
var target : Node2D setget _set_target

func _set_target(value:Node2D)->void:
	print("My target is now %s" % value)
