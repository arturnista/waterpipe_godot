extends Node

const GAME_SCENE = "res://Scenes/MultiplayerGame.tscn"
var text_input

func _ready():
	text_input = get_node("Canvas/ConnectControl/RoomNameInput")
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")

func _on_CreateRoomBtn_pressed():
	print("_on_CreateRoomBtn_pressed")
	$HTTPRequest.request(connection.get_server_url("createRoom"), [], false, HTTPClient.METHOD_POST)

func _on_ConnectRoomBtn_pressed():
	print("_on_ConnectRoomBtn_pressed " + text_input.text)
	connection.room_name = text_input.text
	get_tree().change_scene(GAME_SCENE)
	
func _on_CheckBox_toggled(button_pressed):
	connection.set_is_remote(button_pressed)

func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	connection.room_name = json.result.name
	get_tree().change_scene(GAME_SCENE)

