extends Node

const LOBBY_SCENE = "res://Scenes/Lobby.tscn"
const CREDITS_SCENE = "res://Scenes/Credits.tscn"

func _on_PlayButton_pressed():
	get_tree().change_scene(LOBBY_SCENE)

func _on_CreditsButton_pressed():
	get_tree().change_scene(CREDITS_SCENE)

func _on_ExitButton_pressed():
	get_tree().quit()