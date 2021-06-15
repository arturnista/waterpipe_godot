extends Button

var connection

func _ready():
	connection = get_node("../../../../Connection")

func _on_Button_pressed():
	get_node("/root/UI_SFX/UIClick").play(0)
	connection.send_data("player_leader_start_game", {})
