extends Node

class_name GameController

var tilemap = null
var waterPath = null

var time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	tilemap = get_node("Tilemap")
	tilemap.create(Vector2(0, 0))
	var pipe = null

	pipe = tilemap.create_pipe(Vector2(0, 0))
	pipe.init(PipeDefs.PIPE_TYPE.VERTICAL)
	pipe = tilemap.create_pipe(Vector2(0, 1))
	pipe.init(PipeDefs.PIPE_TYPE.VERTICAL)
	pipe = tilemap.create_pipe(Vector2(0, 2))
	pipe.init(PipeDefs.PIPE_TYPE.VERTICAL)
	pipe = tilemap.create_pipe(Vector2(0, 3))
	pipe.init(PipeDefs.PIPE_TYPE.VERTICAL)
	pipe = tilemap.create_pipe(Vector2(0, 4))
	pipe.init(PipeDefs.PIPE_TYPE.CURVE)

	pipe = tilemap.create_pipe(Vector2(1, 4))
	pipe.init(PipeDefs.PIPE_TYPE.VERTICAL)
	pipe.turn()
	pipe = tilemap.create_pipe(Vector2(2, 4))
	pipe.init(PipeDefs.PIPE_TYPE.VERTICAL)
	pipe.turn()
	pipe = tilemap.create_pipe(Vector2(3, 4))
	pipe.init(PipeDefs.PIPE_TYPE.VERTICAL)
	pipe.turn()

	pipe = tilemap.create_pipe(Vector2(4, 4))
	pipe.init(PipeDefs.PIPE_TYPE.T)
	pipe.turn()
	pipe.turn()
	pipe.turn()

	pipe = tilemap.create_pipe(Vector2(4, 5))
	pipe.init(PipeDefs.PIPE_TYPE.VERTICAL)
	pipe = tilemap.create_pipe(Vector2(4, 6))
	pipe.init(PipeDefs.PIPE_TYPE.VERTICAL)
	pipe = tilemap.create_pipe(Vector2(4, 7))
	pipe.init(PipeDefs.PIPE_TYPE.VERTICAL)

	pipe = tilemap.create_pipe(Vector2(4, 3))
	pipe.init(PipeDefs.PIPE_TYPE.VERTICAL)
	pipe = tilemap.create_pipe(Vector2(4, 2))
	pipe.init(PipeDefs.PIPE_TYPE.VERTICAL)
	pipe = tilemap.create_pipe(Vector2(4, 1))
	pipe.init(PipeDefs.PIPE_TYPE.VERTICAL)

	waterPath = get_node("WaterPath")
	waterPath.init(tilemap, Vector2(0, 0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if (time > 1):
		waterPath.move()
		time = 0
