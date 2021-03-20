class_name Projectile
extends KinematicBody2D

export var speed := 100

func _physics_process(delta):
	var _ignored := move_and_collide(Vector2.RIGHT.rotated(rotation) * speed * delta)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
