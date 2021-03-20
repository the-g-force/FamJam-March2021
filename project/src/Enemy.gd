class_name Enemy
extends Area2D

signal selected

export var _speed := 100
export var _health := 1

var _screensize := Vector2.ZERO
var _screen_center := Vector2.ZERO
var _direction

onready var _sprite := $Sprite


func _ready()->void:
	_screensize = get_viewport_rect().size
	_screen_center = _screensize/2
	_direction = _screen_center-get_global_transform().origin
	_sprite.rotation = _direction.angle()


func _process(delta)->void:
	var _velocity := Vector2.RIGHT.rotated(_direction.angle())
	position += _velocity.normalized()*_speed*delta


func _on_Enemy_input_event(_viewport, event, _shape_idx)->void:
	if event is InputEventMouseButton:
		var e := event as InputEventMouseButton
		if e.pressed:
			emit_signal("selected")


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Enemy_body_entered(body:PhysicsBody2D)->void:
	if body is Projectile:
		_health -= 1
		if _health <= 0:
			queue_free()
