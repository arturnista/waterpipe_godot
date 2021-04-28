extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var connection

# Called when the node enters the scene tree for the first time.
func _ready():
	connection = get_node("../../../Connection")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_Button_pressed():
	connection.send_data("player_leader_start_game", {})
