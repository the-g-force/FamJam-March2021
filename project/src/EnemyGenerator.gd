extends Node2D

signal spawn_enemy(enemy)

const _ENEMY := preload("res://src/Enemy.tscn")

onready var _enemy_spawn_point := $Path2D/EnemySpawnPoint


func _on_Timer_timeout()->void:
	_spawn_enemy()


func _spawn_enemy()->void:
	var enemy := _ENEMY.instance()
	_enemy_spawn_point.unit_offset = rand_range(0,1)
	enemy.position = _enemy_spawn_point.get_global_transform().origin
	emit_signal("spawn_enemy", enemy)
