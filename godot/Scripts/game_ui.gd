extends Control

var room_name = ""

func _ready():
	room_name = get_node("RoomData/RoomName")
	room_name.text = "Room code: " + connection.room_name
