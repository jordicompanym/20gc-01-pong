extends Control

func empezar() -> void:
	get_tree().change_scene_to_file("res://escenas/arena/arena.tscn")

func salir() -> void:
	get_tree().quit()
