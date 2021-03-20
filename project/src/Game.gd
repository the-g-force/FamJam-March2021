extends Node2D


onready var _turret := $Turret
onready var _enemies := $Enemies

func _ready():
	var enemy := preload("res://src/Enemy.tscn").instance()
	enemy.position = Vector2(100,150)


func _add_enemy(enemy:Enemy)->void:
	_enemies.add_child(enemy)
	var _ignored := enemy.connect("selected", self, "_on_Enemy_selected", [enemy])
	

func _on_Enemy_selected(enemy:Enemy)->void:
	_turret.target = enemy


func _on_EnemyGenerator_spawn_enemy(enemy:Enemy)->void:
	_add_enemy(enemy)
