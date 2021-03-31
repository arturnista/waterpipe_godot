extends Node

var pipe_selected = null
var tilemap = null

func _ready():
	add_to_group("player")
	tilemap = get_node("../Tilemap")

func select_pipe(pipe):
	if pipe_selected != null:
		return false

	pipe_selected = pipe
	return true

func _process(delta):
	
	if Input.is_action_just_pressed("player_select_pipe"):
		if pipe_selected != null:
			var mouse_position = get_viewport().get_mouse_position()
			var map_pos = tilemap.get_map_position(mouse_position)

			var pipe_at = tilemap.place_pipe(pipe_selected, map_pos)
			pipe_selected = null
			if pipe_at != null:
				select_pipe(pipe_at)
		else:
			var mouse_position = get_viewport().get_mouse_position()
			var map_pos = tilemap.get_map_position(mouse_position)
			var pipe = tilemap.hold_pipe(map_pos)
			
			if !select_pipe(pipe):
				print("Nao achou o pipe")
			
			print(pipe_selected)

	if Input.is_action_just_pressed("player_rotate_pipe"):
		if pipe_selected != null:
			pipe_selected.turn()

	if pipe_selected != null:
		move_pipe_to_mouse()

func move_pipe_to_mouse():
	var mouse_position = get_viewport().get_mouse_position()
	pipe_selected.set_position(mouse_position)
