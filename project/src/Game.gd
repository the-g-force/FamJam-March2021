extends Control

const _DEATH_EXPLOSION := preload("res://src/Explosion.tscn")

onready var _turret := $Turret
onready var _enemies := $Enemies
onready var _game_over_screen := $GameOver

var _game_over := false

func _ready():
	var enemy := preload("res://src/Enemy.tscn").instance()
	enemy.position = Vector2(100,150)


func _add_enemy(enemy:Enemy)->void:
	_enemies.add_child(enemy)
	var _ignored := enemy.connect("selected", self, "_on_Enemy_selected", [enemy])
	

func _on_Enemy_selected(enemy:Enemy)->void:
	if not _game_over:
		_turret.target = enemy


func _on_EnemyGenerator_spawn_enemy(enemy:Enemy)->void:
	if not _game_over:
		_add_enemy(enemy)


func _on_Turret_dead()->void:
	_game_over()


func _game_over()->void:
	var explosion:CPUParticles2D = _DEATH_EXPLOSION.instance()
	explosion.position = _turret.position
	add_child(explosion)
	explosion.emitting = true
	_turret.queue_free()
	_game_over = true
	_game_over_screen.visible = true
