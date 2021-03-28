extends Node

const WATER_SCENE = "res://Elements/Water.tscn"
const TILE_SCENE = "res://Elements/Tile.tscn"
const PIPE_SCENE = "res://Elements/Pipe.tscn"
const pipes = []
const tileMap = {}
const waterMap = {}

const tile_size = 32
const map_size = Vector2(10, 10)
var map_offset

# Called when the node enters the scene tree for the first time.
func create(offset):
	map_offset = offset
	for x in range(0, map_size.x):
		for y in range(0, map_size.y):

			var tilePosition = Vector2(x, y)
			var position = offset + tilePosition * tile_size

			var tile = load(TILE_SCENE)
			var tileNode = tile.instance()
			add_child(tileNode)
			tileNode.set_position(position)
			
			tileMap[tilePosition] = null
	
	return pipes

func create_pipe(pos):
	var tilePosition = pos

	var pipe = load(PIPE_SCENE)
	var pipeNode = pipe.instance()
	add_child(pipeNode)

	pipes.push_back(pipeNode)
	place_pipe(pipeNode, tilePosition)

	return pipeNode

func place_pipe(pipe, position):
	if !is_inside_map(position):
		return false

	if tileMap[position] != null:
		return false

	pipe.set_position(get_world_position(position))
	tileMap[position] = pipe
	return true
		
func hold_pipe(position):
	if !is_inside_map(position):
		return null
	if waterMap.has(position):
		return null

	var pipe = tileMap[position]
	
	if !pipe.is_draggable:
		return null

	tileMap[position] = null
	return pipe

func get_pipe_at_position(position):
	if !is_inside_map(position):
		return null

	return tileMap[position]

func is_inside_map(position):
	return tileMap.has(position)

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

func has_water(position):
	return waterMap.has(position)

func place_water(position):
	var water = load(WATER_SCENE)
	var waterNode = water.instance()
	add_child(waterNode)

	waterNode.set_position(get_world_position(position))
	waterMap[position] = waterNode
