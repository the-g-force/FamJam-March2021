extends Node2D

const _Projectile := preload("res://src/Projectile.tscn")

# In radians per second
export var rotation_speed := 0.1

# The node to track toward
var target : Node2D


func _physics_process(_delta):
	if target == null:
		return
	
	var target_rotation := _compute_desired_rotation()
	var full_amount := _short_angle_dist(rotation, target_rotation)
	if full_amount < 0:
		rotate(max(full_amount, -rotation_speed))
	else:
		rotate(min(full_amount, rotation_speed))
	
	

func _compute_desired_rotation()->float:
	var my_global_pos := get_global_transform().origin
	var target_global_pos := target.get_global_transform().origin
	var angle_to_target = (target_global_pos- my_global_pos).angle()
	return angle_to_target


# See https://gist.github.com/shaunlebron/8832585
func _short_angle_dist(from, to)->float:
	var max_angle = PI * 2
	var difference = fmod(to - from, max_angle)
	return fmod(2 * difference, max_angle) - difference


func _on_ShotTimer_timeout():
	if target != null:
		var projectile := _Projectile.instance()
		projectile.position = position
		projectile.rotation = rotation
		get_parent().add_child(projectile)
		

func damage():
	print("I WAS HURT")
