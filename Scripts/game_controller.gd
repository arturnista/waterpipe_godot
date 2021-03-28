extends Node

class_name GameController

var tilemap = null
var waterPath = null

# Called when the node enters the scene tree for the first time.
func _ready():
	tilemap = get_node("Tilemap")
	tilemap.create(Vector2(0, 0))
	var pipe = null

	pipe = tilemap.create_pipe(Vector2(0, 0))
	pipe.init(PipeDefs.PIPE_TYPE.START)
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
	pipe.init(PipeDefs.PIPE_TYPE.VERTICAL)
	pipe.turn()
	pipe = tilemap.create_pipe(Vector2(5, 4))
	pipe.init(PipeDefs.PIPE_TYPE.VERTICAL)
	pipe.turn()
	pipe = tilemap.create_pipe(Vector2(6, 4))
	pipe.init(PipeDefs.PIPE_TYPE.VERTICAL)
	pipe.turn()
	pipe = tilemap.create_pipe(Vector2(7, 4))
	pipe.init(PipeDefs.PIPE_TYPE.VERTICAL)
	pipe.turn()
	pipe = tilemap.create_pipe(Vector2(8, 4))
	pipe.init(PipeDefs.PIPE_TYPE.VERTICAL)
	pipe.turn()

	pipe = tilemap.create_pipe(Vector2(9, 4))
	pipe.init(PipeDefs.PIPE_TYPE.CURVE)
	pipe.turn()
	pipe.turn()

	pipe = tilemap.create_pipe(Vector2(9, 5))
	pipe.init(PipeDefs.PIPE_TYPE.VERTICAL)
	pipe = tilemap.create_pipe(Vector2(9, 6))
	pipe.init(PipeDefs.PIPE_TYPE.VERTICAL)
	pipe = tilemap.create_pipe(Vector2(9, 7))
	pipe.init(PipeDefs.PIPE_TYPE.VERTICAL)
	pipe = tilemap.create_pipe(Vector2(9, 8))
	pipe.init(PipeDefs.PIPE_TYPE.VERTICAL)
	
	pipe = tilemap.create_pipe(Vector2(9, 9))
	pipe.init(PipeDefs.PIPE_TYPE.END)
	pipe.turn()
	pipe.turn()

	waterPath = get_node("WaterPath")
	waterPath.init(tilemap, Vector2(0, 0))

