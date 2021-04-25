extends Node


const GAME_SCENE = "res://Scenes/MultiplayerGame.tscn"

func _process(delta):
		
	if Input.is_action_just_pressed("player_rotate_pipe"):
		get_tree().change_scene(GAME_SCENE)
