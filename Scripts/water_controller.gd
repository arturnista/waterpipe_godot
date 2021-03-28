extends Node

var tilemap = null

var positions = []

func init(tm, initialPosition):
	tilemap = tm
	tilemap.place_water(initialPosition)
	positions = [initialPosition]
	
func move():
	var result_positions = []
	for pos in positions:
		var pipe = tilemap.get_pipe_at_position(pos)
		if pipe != null:
			for exit in pipe.exits:
				result_positions.push_back(pos + exit)
	
	print(result_positions)
	for r in result_positions:
		tilemap.place_water(r)
	
	positions = result_positions

