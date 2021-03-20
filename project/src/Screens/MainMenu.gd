extends Control

export var game_scene : PackedScene

func _on_PlayButton_pressed():
	var _ignored := get_tree().change_scene_to(game_scene)
