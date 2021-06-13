extends Button

var connection

func _ready():
	connection = get_node("../../../Connection")

func _on_Button_pressed():
	connection.send_data("player_leader_start_game", {})
