# extends Node

# class_name GameController

# var rng = RandomNumberGenerator.new()
# var tilemap = null
# var waterPath = null

# # Called when the node enters the scene tree for the first time.
# func _ready():
# 	tilemap = get_node("Tilemap")
# 	var mapSize = Vector2(10, 10)
# 	tilemap.create(Vector2(0, 0), mapSize)
# 	rng.randomize()
# 	var pipe = null

# 	var start = Vector2(floor(rng.randf_range(0, mapSize.x)), 0)
# 	var end = Vector2(floor(rng.randf_range(0, mapSize.x)), mapSize.y - 1)

# 	var startPipe = tilemap.create_pipe(start)
# 	startPipe.init(PipeDefs.PIPE_TYPE.START)

# 	var endPipe = tilemap.create_pipe(end)
# 	endPipe.init(PipeDefs.PIPE_TYPE.END)
# 	endPipe.turn()
# 	endPipe.turn()

# 	var verticalSize = end.y - start.y
# 	var horizontalSize = end.x - start.x
# 	var curvesSize = 2

# 	var pipesTypes = []
# 	for _i in range(0, verticalSize):
# 		pipesTypes.push_back(PipeDefs.PIPE_TYPE.VERTICAL)
# 	for _i in range(0, horizontalSize):
# 		pipesTypes.push_back(PipeDefs.PIPE_TYPE.VERTICAL)
# 	for _i in range(0, curvesSize):
# 		pipesTypes.push_back(PipeDefs.PIPE_TYPE.CURVE)
	
# 	var totalTiles = mapSize.x * mapSize.y
# 	var totalRandomPipes = totalTiles - curvesSize - horizontalSize - verticalSize - 2
# 	for _i in range(0, totalRandomPipes):
# 		var rareType = round(rng.randf_range(0, 100))
			
# 		var type = round(rng.randf_range(0, 1))
# 		if type == 0:
# 			if rareType > 90:
# 				pipesTypes.push_back(PipeDefs.PIPE_TYPE.T)
# 			else:
# 				pipesTypes.push_back(PipeDefs.PIPE_TYPE.VERTICAL)
# 		elif type == 1:
# 			if rareType > 90:
# 				pipesTypes.push_back(PipeDefs.PIPE_TYPE.ALL)
# 			else:
# 				pipesTypes.push_back(PipeDefs.PIPE_TYPE.CURVE)

# 	pipesTypes.shuffle()

# 	var x = 0
# 	var y = 0
# 	for i in range(0, pipesTypes.size()):
# 		if (start.x != x or start.y != y) and (end.x != x or end.y != y):
# 			tilemap.create_pipe(Vector2(x, y)).init(pipesTypes[i])

# 		x += 1
# 		if x >= mapSize.x:
# 			x = 0
# 			y += 1

# 	waterPath = get_node("WaterPath")
# 	waterPath.init(tilemap, start)

