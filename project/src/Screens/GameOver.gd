extends Control


func _on_PlayAgain_pressed():
	var _ignored := get_tree().change_scene("res://src/Game.tscn")


func _on_MainMenu_pressed():
	var _ignored := get_tree().change_scene("res://src/Screens/MainMenu.tscn")
