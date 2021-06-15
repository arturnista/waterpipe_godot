extends Node

const WATER_SCENE = "res://Elements/Water.tscn"
const TILE_SCENE = "res://Elements/Tile.tscn"
const PIPE_SCENE = "res://Elements/Pipe.tscn"

const tile_size = 60
var created = false
var pipes = {}
var map_size
var outside_size

# var projectResolution = Vector2( Globals.get("display/width"), Globals.get("display/height") )
var offset = Vector2(0, 0)

func replicate(server_data):
	map_size = server_data.size
	outside_size = server_data.outsideSize
	var rect_size = get_viewport().get_visible_rect().size
	offset = Vector2(
		(rect_size.x / 2) - ((map_size / 2) * tile_size),
		0
	)
	if !created:
		created = true;

		for x in range(0, map_size):
			for y in range(0, map_size):
				var tile_position = Vector2(x, y)
				var position = tile_position * tile_size

				var tile = load(TILE_SCENE)
				var tileNode = tile.instance()
				add_child(tileNode)
				tileNode.set_position(offset + position)
				
		for y in range(0, outside_size):
			var tile_position = Vector2(map_size + 2, y)
			var position = tile_position * tile_size

			var tile = load(TILE_SCENE)
			var tileNode = tile.instance()
			add_child(tileNode)
			tileNode.set_position(offset + position)

		for tile_data in server_data.tiles:

			var pipe = load(PIPE_SCENE)
			var pipeNode = pipe.instance()
			add_child(pipeNode)

			if typeof(tile_data.position) == TYPE_DICTIONARY:
				var tile_position = Vector2(tile_data.position.x, tile_data.position.y)
				var position = tile_position * tile_size
				pipeNode.set_position(offset + position)

			pipeNode.create(tile_data)
			pipes[tile_data.id] = pipeNode
	else:
		for tile_data in server_data.tiles:
			if typeof(tile_data.position) == TYPE_DICTIONARY:
				var tile_position = Vector2(tile_data.position.x, tile_data.position.y)
				var position = tile_position * tile_size
				pipes[tile_data.id].set_position(offset + position)
			else:
				pipes[tile_data.id].set_position(offset + Vector2(500, 500))

			pipes[tile_data.id].replicate(tile_data)

func get_pipe_by_id(id):
	return pipes[id]

func get_world_position(map_position):
	return Vector2(
		map_position.x * tile_size,
		map_position.y * tile_size
	)

func get_map_position(world_position):
	var world_relative = world_position - offset
	var map_position = Vector2(
		floor(world_relative.x / tile_size),
		floor(world_relative.y / tile_size)
	)
	return map_position
