extends Node

var local_server_url = "http://localhost:3000"
var remote_server_url = "http://plumbing-crash.herokuapp.com"

var local_websocket_url = "ws://localhost:3000"
var remote_websocket_url = "ws://plumbing-crash.herokuapp.com"

var room_name = ""

var local = {
	"server_url": "http://localhost:3000",
	"websocket_url": "ws://localhost:3000",
}

var remote = {
	"server_url": "http://plumbing-crash.herokuapp.com",
	"websocket_url": "ws://plumbing-crash.herokuapp.com",
}

var current_url = {}

func _ready():
	current_url = local

func set_is_remote(data):
	print(data);
	if data:
		current_url = remote
	else:
		current_url = local
	print(current_url.websocket_url);

func get_server_url(path):
	return current_url.server_url + "/" + path

func get_room_url():
	return current_url.websocket_url + "/" + room_name
