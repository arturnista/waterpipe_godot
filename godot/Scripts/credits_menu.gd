extends Node

const START_SCENE = "res://Scenes/Start.tscn"

func _on_BackButton_pressed():
	get_tree().change_scene(START_SCENE)
