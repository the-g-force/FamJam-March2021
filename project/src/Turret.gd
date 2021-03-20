extends Node2D

signal dead

const _Projectile := preload("res://src/Projectile.tscn")

# In radians per second
export var rotation_speed := 0.1

# How close can we be, in radians, to target rotation, before we start shooting
export var epsilon := 0.01
export var health := 3

# The node to track toward
var target : Node2D setget _set_target

onready var _shot_timer := $ShotTimer


func _physics_process(_delta):
	if target == null or not is_instance_valid(target):
		return
	
	var target_rotation := _compute_desired_rotation()
	var full_amount := _short_angle_dist(rotation, target_rotation)
	if full_amount < 0:
		rotate(max(full_amount, -rotation_speed))
	else:
		rotate(min(full_amount, rotation_speed))
	
	if _shot_timer.time_left == 0 and abs(_short_angle_dist(rotation, target_rotation)) < epsilon:
		_fire()
	

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


func _fire():
	var projectile := _Projectile.instance()
	projectile.position = position
	projectile.rotation = rotation
	get_parent().add_child(projectile)
	_shot_timer.start()
	$ShootSound.play()


func damage():
	health -= 1
	$HurtSound.play()
	if health <= 0:
		emit_signal("dead")


func _set_target(value:Enemy)->void:
	assert(value!=null)
	target = value
	if not value.is_connected("damaged", self, "_on_target_damaged"):
		value.connect("damaged", self, "_on_target_damaged", [value], CONNECT_ONESHOT)
	

func _on_target_damaged(new_node:Enemy, orig_target:Enemy)->void:
	if target == orig_target and new_node != null:
		_set_target(new_node)
