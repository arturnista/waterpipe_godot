extends StaticBody2D

var player = null
var exits = []
var sprite = null
var pipeType = null

var is_draggable = true

func _ready():
	pass

func turn():
	sprite.rotate(deg2rad(90))
	for i in range(0, len(exits)):
		var x = exits[i].x
		var y = exits[i].y

		if x == 1 or x == -1: x = 0
		elif exits[i].y == 1: x = -1
		elif exits[i].y == -1: x = 1

		if y == 1 or y == -1: y = 0
		elif exits[i].x == -1: y = -1
		elif exits[i].x == 1: y = 1

		exits[i] = Vector2(x, y)

	update()

func init(type):
	var startNode = get_child(0).get_child(0)
	var endNode = get_child(0).get_child(0)
	var verticalNode = get_child(0).get_child(1)
	var curveNode = get_child(0).get_child(2)
	var tNode = get_child(0).get_child(3)
	var allNode = get_child(0).get_child(4)
	
	startNode.hide()
	verticalNode.hide()
	curveNode.hide()
	tNode.hide()
	allNode.hide()

	pipeType = type

	if type == PipeDefs.PIPE_TYPE.START:
		is_draggable = false
		sprite = startNode
		startNode.show()
		exits = [
			Vector2(0, 1)
		]

	elif type == PipeDefs.PIPE_TYPE.VERTICAL:
		sprite = verticalNode
		verticalNode.show()
		exits = [
			Vector2(0, 1),
			Vector2(0, -1)
		]

	elif type == PipeDefs.PIPE_TYPE.CURVE:
		sprite = curveNode
		curveNode.show()
		exits = [
			Vector2(0, -1),
			Vector2(1, 0)
		]

	elif type == PipeDefs.PIPE_TYPE.T:
		sprite = tNode
		tNode.show()
		exits = [
			Vector2(0, -1),
			Vector2(1, 0),
			Vector2(-1, 0)
		]

	elif type == PipeDefs.PIPE_TYPE.ALL:
		sprite = allNode
		allNode.show()
		exits = [
			Vector2(0, -1),
			Vector2(0, 1),
			Vector2(1, 0),
			Vector2(-1, 0)
		]

	if type == PipeDefs.PIPE_TYPE.END:
		is_draggable = false
		sprite = endNode
		endNode.show()
		exits = [
			Vector2(0, 1)
		]

	update()
