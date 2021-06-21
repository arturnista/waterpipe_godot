extends Control

var room_name = ""
var websocket = null

func _ready():
	get_node("/root/UI_SFX/MenuMusic").stop()
	room_name = get_node("RoomData/RoomName")
	room_name.text = "Room code: " + connection.room_name
	websocket = get_node("../Connection")

func _on_DisconnectButton_pressed():
	websocket.close_connection()
	get_node("/root/UI_SFX/MenuMusic").play(0)
