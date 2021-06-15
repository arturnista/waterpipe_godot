extends Node

const LOBBY_SCENE = "res://Scenes/Lobby.tscn"

const WIN_SCENE = "res://Scenes/Win.tscn"
const LOSE_SCENE = "res://Scenes/Lose.tscn"
const LEADER_SCENE = "res://Elements/UI_Leader.tscn"
const USER_SCENE = "res://Elements/UI_User.tscn"


# The URL we will connect to
# export var websocket_url = "ws://localhost:3000/"
# export var websocket_url = "ws://plumbing-crash.herokuapp.com"

var tilemap = null
var player = null
var game_state = ''
var user_scene_loaded = null
var first_state = true
# Our WebSocketClient instance
var _client = WebSocketClient.new()

func _ready():
	player = get_node("Player")
	tilemap = get_node("Tilemap")
	# Connect base signals to get notified of connection open, close, and errors.
	_client.connect("connection_closed", self, "_closed")
	_client.connect("connection_error", self, "_closed")
	_client.connect("connection_established", self, "_connected")
	# This signal is emitted when not using the Multiplayer API every time
	# a full packet is received.
	# Alternatively, you could check get_peer(1).get_available_packets() in a loop.
	_client.connect("data_received", self, "_on_data")

	# Initiate connection to the given URL.
	var err = _client.connect_to_url(connection.get_room_url())
	if err != OK:
		print("Unable to connect")
		set_process(false)

func _closed(was_clean = false):
	# was_clean will tell you if the disconnection was correctly notified
	# by the remote peer before closing the socket.
	print("Closed, clean: ", was_clean)
	set_process(false)
	get_tree().change_scene(LOBBY_SCENE)

func _connected(proto = ""):
	# This is called on connection, "proto" will be the selected WebSocket
	# sub-protocol (which is optional)
	print("Connected with protocol: ", proto)

func close_connection():
	_client.disconnect_from_host()

# Process receive data
func _on_data():
	var message_receive = _client.get_peer(1).get_packet().get_string_from_utf8()
	var result_json = JSON.parse(message_receive)

	if result_json.error == OK:  # If parse OK
		var message = result_json.result
		if message.event == 'player_register':
			var scene = null
			if message.data.leader:
				scene = load(LEADER_SCENE)
			else:
				scene = load(USER_SCENE)
			user_scene_loaded = scene.instance()
			add_child(user_scene_loaded)
			player.register(message.data)
		elif message.event == 'gameState':
			if first_state:
				first_state = false
				$SFX/GameMusic.play(0)

			var player_received
			for player_it in message.data.players:
				if(player_it["id"] == player.id):
					player_received = player_it
					break

			game_state = message.data.state
			if game_state == "GAME":

				if user_scene_loaded != null:
					remove_child(user_scene_loaded)
					user_scene_loaded = null

				tilemap.replicate(message.data.map)
				player.replicate(player_received)
			if game_state == "WIN":
				first_state = true
				get_tree().change_scene(WIN_SCENE)
			if game_state == "LOSE":
				first_state = true
				get_tree().change_scene(LOSE_SCENE)
		elif message.event == 'game-freeze':
			$SFX/GameFreeze.play(0)
		elif message.event == 'game-water-start':
			$SFX/GameWaterStep.play(0)
		elif message.event == 'game-water-step':
			$SFX/GameWaterStep.play(0)

func _process(delta):
	# emission will only happen when calling this function.
	_client.poll()

func send_data(event, data):
	var dic = {
		"event": event,
		"data": data
	}
	_client.get_peer(1).put_packet(JSON.print(dic).to_utf8())
