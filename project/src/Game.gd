extends Node2D

const _DEATH_EXPLOSION := preload("res://src/Explosion.tscn")

onready var _turret := $Turret
onready var _enemies := $Enemies
onready var _game_over_score_label := $Control/GameOver/VBoxContainer2/ScoreLabel
onready var _health_label := $HUD/Health
onready var _score_label := $HUD/Score

var _is_game_over := false
var _score := 0


func _add_enemy(enemy:Enemy)->void:
	_enemies.add_child(enemy)
	var _ignored := enemy.connect("selected", self, "_on_Enemy_selected", [enemy])
	_ignored = enemy.connect("damaged", self, "_on_Enemy_damaged")
	

func _on_Enemy_selected(enemy:Enemy)->void:
	if not _is_game_over:
		_turret.target = enemy
		

func _on_Enemy_damaged(new_node:Enemy, score)->void:
	_score += score
	_score_label.text = "Score: "+str(_score)
	if new_node != null:
		_add_enemy(new_node)


func _on_EnemyGenerator_spawn_enemy(enemy:Enemy)->void:
	if not _is_game_over:
		_add_enemy(enemy)


func _on_Turret_dead()->void:
	_game_over()


func _game_over()->void:
	var explosion:CPUParticles2D = _DEATH_EXPLOSION.instance()
	explosion.position = _turret.position
	add_child(explosion)
	explosion.emitting = true
	_turret.queue_free()
	_is_game_over = true
	_game_over_score_label.text = "You got "+str(_score)+" points!"
	$AnimationPlayer.play("GameOver")


func _on_Turret_damaged(health_remaining:int)->void:
	_health_label.text = "Health: "+str(health_remaining)
