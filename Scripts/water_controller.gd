extends Node

var tilemap = null

var end_positions = []
var time = 0
var step_time = 1
var moving = true

func init(tm, initialPosition):
	tilemap = tm
	tilemap.place_water(initialPosition)
	end_positions = [initialPosition]
	
func _process(delta):
	if !moving: return

	time += delta
	if (time > step_time):
		step()
		time = 0

func lost():
	print("Perdeu")
	moving = false

func win():
	print("GANHOU")
	moving = false

func step():
	var result_positions = []
	for pos in end_positions:
		var pipe = tilemap.get_pipe_at_position(pos)
		if pipe == null:
			lost()
			return

		for exit in pipe.exits:
			var final_position = pos + exit

			var final_pipe = tilemap.get_pipe_at_position(final_position)
			if final_pipe == null:
				lost()
				return

			var find_valid_position = false
			for final_exit in final_pipe.exits:
				var test_position = final_position + final_exit
				if test_position == pos:
					find_valid_position = true
					break
			
			if !find_valid_position:
				lost()
				return

			if !tilemap.has_water(final_position):
				result_positions.push_back(final_position)
			
			if final_pipe.pipeType == PipeDefs.PIPE_TYPE.END:
				win()
				return
	
	for r in result_positions:
		tilemap.place_water(r)
	
	end_positions = result_positions

