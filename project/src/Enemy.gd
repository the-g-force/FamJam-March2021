class_name Enemy
extends KinematicBody2D

signal selected

const _TYPES := ["Sub"]
const _MAX_HEALTH_BY_TYPE := {"Sub":3}

export var speed := 100

var _health := 1
var _type := ""

onready var _sprite := $Sprite


func _ready()->void:
	# Copy the collision shape into the area2d clickable shape
	_copy_shape($CollisionShape2D, $Area2D/CollisionShape2D)

	var type_index := randi()%_TYPES.size()
	_type = _TYPES[type_index]
	var max_health_for_type:int = _MAX_HEALTH_BY_TYPE[_type]
	_health = (randi()%max_health_for_type)+1
	_sprite.play(_type+str(_health))
	speed = 70-_health*10


func _copy_shape(from:CollisionShape2D, to:CollisionShape2D)->void:
	to.shape = from.shape
	to.rotation = from.rotation


func damage():
	_health -= 1
	if _health <= 0:
		queue_free()
	else:
		_sprite.play(_type+str(_health))
		speed += 10


func _process(delta)->void:
	var direction := Vector2.RIGHT.rotated(rotation)
	var collision := move_and_collide(direction * speed * delta)
	if collision and collision.collider.has_method("damage"):
		collision.collider.damage()
		queue_free()
		

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		var e := event as InputEventMouseButton
		if e.pressed:
			emit_signal("selected")
