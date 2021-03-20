extends Control

export var game_scene : PackedScene

onready var _fullscreen_toggle := $FullscreenToggle

func _ready():
	_fullscreen_toggle.pressed = OS.window_fullscreen


func _on_PlayButton_pressed():
	var _ignored := get_tree().change_scene_to(game_scene)


func _on_FullscreenToggle_pressed():
	OS.window_fullscreen = _fullscreen_toggle.pressed
