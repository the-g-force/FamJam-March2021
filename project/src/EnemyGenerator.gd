extends Node2D

signal spawn_enemy(enemy)

const _ENEMY := preload("res://src/Enemy.tscn")

export var radius := 150.0


func _on_Timer_timeout()->void:
	_spawn_enemy()


func _spawn_enemy()->void:
	var enemy := _ENEMY.instance()
	var theta := rand_range(0, TAU)
	
	enemy.position = get_global_transform().origin + radius * Vector2(cos(theta),sin(theta))
	
	enemy.rotation = theta - PI
	emit_signal("spawn_enemy", enemy)
