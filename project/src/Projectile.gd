class_name Projectile
extends KinematicBody2D

export var speed := 200

func _physics_process(delta):
	var collision := move_and_collide(Vector2.RIGHT.rotated(rotation) * speed * delta)
	if collision and collision.collider.has_method("damage"):
		collision.collider.damage()
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
