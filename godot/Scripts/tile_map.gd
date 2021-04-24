extends Node

const WATER_SCENE = "res://Elements/Water.tscn"
const TILE_SCENE = "res://Elements/Tile.tscn"
const PIPE_SCENE = "res://Elements/Pipe.tscn"

const tile_size = 32
var created = false
var pipes = {}
var map_size

func replicate(server_data):
	map_size = server_data.size
	if !created:
		created = true;

		for tile_data in server_data.tiles:

			# var tile = load(TILE_SCENE)
			# var tileNode = tile.instance()
			# add_child(tileNode)
			# tileNode.set_position(position)

			var pipe = load(PIPE_SCENE)
			var pipeNode = pipe.instance()
			add_child(pipeNode)

			if typeof(tile_data.position) == TYPE_DICTIONARY:
				var tile_position = Vector2(tile_data.position.x, tile_data.position.y)
				var position = tile_position * tile_size
				pipeNode.set_position(position)

			pipeNode.create(tile_data)
			pipes[tile_data.id] = pipeNode
	else:
		for tile_data in server_data.tiles:
			if typeof(tile_data.position) == TYPE_DICTIONARY:
				var tile_position = Vector2(tile_data.position.x, tile_data.position.y)
				var position = tile_position * tile_size
				pipes[tile_data.id].set_position(position)
			else:
				pipes[tile_data.id].set_position(Vector2(500, 500))

			pipes[tile_data.id].replicate(tile_data)
				
func get_pipe_by_id(id):
	return pipes[id]

func get_world_position(map_position):
	return Vector2(
		map_position.x * tile_size,
		map_position.y * tile_size
	)

func get_map_position(world_position):
	var map_position = Vector2(
		floor(world_position.x / tile_size),
		floor(world_position.y / tile_size)
	)
	return map_position
