extends StaticBody2D

const WATER_SCENE = "res://Elements/Water.tscn"

const PIPE_STYLE_NORMAL = "STYLE_NORMAL"
const PIPE_STYLE_OUTSIDE = "STYLE_OUTSIDE"
const PIPE_STYLE_STATIC = "STYLE_STATIC"
const PIPE_STYLE_START = "STYLE_START"
const PIPE_STYLE_END = "STYLE_END"
    
const PIPE_VERTICAL = "VERTICAL"
const PIPE_CURVE = "CURVE"
const PIPE_T = "T"
const PIPE_ALL = "ALL"

const PIPE_SPECIAL_NORMAL = "SPECIAL_NORMAL"
const PIPE_SPECIAL_FREEZE = "SPECIAL_FREEZE"

var player = null
var exits = []
var sprite = null
var pipe_type = null
var pipe_style = null
var pipe_special = null
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

	var specialFreeze = get_node("Special/Freeze")
	
	startNode.hide()
	verticalNode.hide()
	curveNode.hide()
	tNode.hide()
	allNode.hide()
	specialFreeze.hide()

	pipe_type = server_data.type
	pipe_style = server_data.style
	pipe_special = server_data.special

	if pipe_style == PIPE_STYLE_START:
		is_draggable = false
		sprite = startNode
		startNode.show()
		sprite.modulate = Color.green

	elif pipe_style == PIPE_STYLE_END:
		is_draggable = false
		sprite = endNode
		endNode.show()
		
		sprite.modulate = Color.red

	elif pipe_type == PIPE_VERTICAL:
		sprite = verticalNode
		verticalNode.show()

	elif pipe_type == PIPE_CURVE:
		sprite = curveNode
		curveNode.show()

	elif pipe_type == PIPE_T:
		sprite = tNode
		tNode.show()

	elif pipe_type == PIPE_ALL:
		sprite = allNode
		allNode.show()

	if pipe_style == PIPE_STYLE_NORMAL:
		sprite.modulate = Color("#455ede")
	elif pipe_style == PIPE_STYLE_STATIC:
		sprite.modulate = Color("#757575")
	elif pipe_style == PIPE_STYLE_OUTSIDE:
		sprite.modulate = Color("#9c27b0")
	
	if pipe_special == PIPE_SPECIAL_NORMAL:
		specialFreeze.hide()
	elif pipe_special == PIPE_SPECIAL_FREEZE:
		specialFreeze.show()

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
