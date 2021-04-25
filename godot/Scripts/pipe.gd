extends StaticBody2D

const WATER_SCENE = "res://Elements/Water.tscn"

var player = null
var exits = []
var sprite = null
var pipe_type = null
var pipe_style = null
var has_water = false

var is_draggable = true
var id = 0

func _ready():
	pass

func turn():
	pass

func create(server_data):
	id = int(server_data.id)

	has_water = false
	
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

	pipe_type = server_data.type
	pipe_style = server_data.style

	if pipe_style == "STYLE_START":
		is_draggable = false
		sprite = startNode
		startNode.show()

	elif pipe_style == "STYLE_END":
		is_draggable = false
		sprite = endNode
		endNode.show()

		sprite.modulate = Color.red

	elif pipe_type == "VERTICAL":
		sprite = verticalNode
		verticalNode.show()

	elif pipe_type == "CURVE":
		sprite = curveNode
		curveNode.show()

	elif pipe_type == "T":
		sprite = tNode
		tNode.show()

	elif pipe_type == "ALL":
		sprite = allNode
		allNode.show()

	sprite.rotation_degrees = server_data.angle
	update()

func replicate(server_data):
	has_water = int(server_data.water)
	sprite.rotation_degrees = server_data.angle
	update()

	if has_water == 1:
		var tile = load(WATER_SCENE)
		var tileNode = tile.instance()
		add_child(tileNode)
		tileNode.set_position(Vector2.ZERO)
