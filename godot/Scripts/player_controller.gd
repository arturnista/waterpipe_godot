extends Node

var tilemap = null
var connection = null

var actions = {
	"select_pipe": false,
	"rotate_pipe": false,
	"position": {"x":0, "y":0}
}

var input_emit_delay = .1
var input_emit_time = 0
var id = 0
var pipe_selected = null
var is_leader = false

func _ready():
	add_to_group("player")
	tilemap = get_node("../Tilemap")
	connection = get_node("../../Connection")

func register(server_data):
	id = int(server_data.id)
	is_leader = server_data.leader
	pass

func replicate(server_data):
	is_leader = server_data.leader
	if int(server_data.tileHold) != -1:
		pipe_selected = tilemap.get_pipe_by_id(server_data.tileHold)
	else:
		pipe_selected = null

func _process(delta):
	var mouse_position = get_viewport().get_mouse_position()
	
	if pipe_selected  != null:
		pipe_selected.set_position(mouse_position)
		
	if Input.is_action_just_pressed("player_select_pipe"):
		actions.select_pipe = true
		
	if Input.is_action_just_pressed("player_rotate_pipe"):
		actions.rotate_pipe = true
	
	if is_leader:
		if Input.is_action_just_pressed("player_leader_start_game"):
			connection.send_data("player_leader_start_game", {})
			
		if Input.is_action_just_pressed("player_leader_fast"):
			connection.send_data("player_leader_fast", {})

	input_emit_time += delta
	if input_emit_time > input_emit_delay:
		input_emit_time = 0

		var map_pos = tilemap.get_map_position(mouse_position)
		actions.position = {
			"x": map_pos.x,
			"y": map_pos.y
		}
		
		connection.send_data("player_input", actions)
		actions.select_pipe = false
		actions.rotate_pipe = false

