class_name Enemy
extends KinematicBody2D

signal selected
signal damaged(new_node)

export var speed := 100
export var next : PackedScene = null

func _ready()->void:
	var area2d := Area2D.new()
	var collisionshape := CollisionShape2D.new()
	area2d.add_child(collisionshape)
	collisionshape.shape = $CollisionShape2D.shape
	collisionshape.transform = $CollisionShape2D.transform
	add_child(area2d)
	area2d.connect("input_event", self, "_on_Area2D_input_event")
	
	set_collision_mask_bit(0, false)
	set_collision_mask_bit(1, true)


func damage():
	if next != null:
		var new_node : Enemy = next.instance()
		new_node.transform = transform
		emit_signal("damaged", new_node)
		queue_free()
	else:
		emit_signal("damaged", null)
		queue_free()


func _process(delta)->void:
	var direction := Vector2.RIGHT.rotated(rotation)
	var collision := move_and_collide(direction * speed * delta)
	if collision and collision.collider.has_method("damage"):
		collision.collider.damage()
		queue_free()


func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		var e := event as InputEventMouseButton
		if e.pressed:
			emit_signal("selected")
