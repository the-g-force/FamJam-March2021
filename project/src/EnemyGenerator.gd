extends Node2D

signal spawn_enemy(enemy)

const _ENEMY := preload("res://src/Enemies/Submarine.tscn")

export var radius := 150.0
export var initial_delay := 0.5          # Time before first spawn
export var spawn_timer_delay := 4.0      # Seconds between spawn
export var spawn_increase_rate := 0.03   # How much faster is the next one

func _ready():
	$Timer.wait_time = spawn_timer_delay
	yield(get_tree().create_timer(initial_delay), "timeout")
	_spawn_enemy()


func _on_Timer_timeout()->void:
	_spawn_enemy()


func _spawn_enemy()->void:
	var enemy := _ENEMY.instance()
	var theta := rand_range(0, TAU)
	
	enemy.position = get_global_transform().origin + radius * Vector2(cos(theta),sin(theta))
	
	enemy.rotation = theta - PI
	emit_signal("spawn_enemy", enemy)
	
	# Make them come a little faster
	$Timer.wait_time *= 1.0 - spawn_increase_rate
	$Timer.start()
