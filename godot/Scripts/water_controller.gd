# extends Node

# var tilemap = null

# var end_positions = []
# var time = 0
# var step_time = 1
# var started = true
# var moving = true
# var initial_position

# func init(tm, initialPosition):
# 	tilemap = tm
# 	initial_position = initialPosition
# 	moving = false
# 	started = false
	
# func _process(delta):
# 	if !started:
# 		time += delta
# 		if (time > 10):
# 			start()
# 			time = 0

# 	if !moving: return

# 	time += delta
# 	if (time > step_time):
# 		step()
# 		time = 0

# func lost():
# 	print("Perdeu")
# 	moving = false

# func win():
# 	print("GANHOU")
# 	moving = false

# func start():
# 	started = true
# 	moving = true
# 	tilemap.place_water(initial_position)
# 	end_positions = [initial_position]

# func step():
# 	var result_positions = []
# 	var find_at_least_one_pipe = false
# 	for pos in end_positions:

# 		var pipe = tilemap.get_pipe_at_position(pos)
# 		if pipe == null:
# 			lost()
# 			return

# 		for exit in pipe.exits:
# 			var final_position = pos + exit

# 			var next_movement_pipe = tilemap.get_pipe_at_position(final_position)
# 			if next_movement_pipe != null:

# 				# Tenta achar a mesma posição nas saídas do cano
# 				# Isso indica que o cano tem uma entrada nessa posição
# 				# var find_same_position = false
# 				# for final_exit in next_movement_pipe.exits:
# 				# 	var test_position = final_position + final_exit
# 				# 	if test_position == pos:
# 				# 		find_same_position = true
# 				# 		break
				
# 				# if !find_same_position:
# 				# 	lost()
# 				# 	return

# 				if !tilemap.has_water(final_position):
# 					find_at_least_one_pipe = true
# 					result_positions.push_back(final_position)
				
# 				if next_movement_pipe.pipeType == PipeDefs.PIPE_TYPE.END:
# 					win()
# 					return
# 			else:
# 				if !result_positions.has(pos):
# 					result_positions.push_back(pos)
		
# 	if !find_at_least_one_pipe:
# 		lost()
# 		return

# 	for r in result_positions:
# 		tilemap.place_water(r)
	
# 	end_positions = result_positions

