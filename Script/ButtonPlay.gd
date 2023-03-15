extends Button

var next_scene = preload("res://Scenes/Cenário.tscn")

func _pressed():
	var group = $"../Control/VBoxContainer/HBoxContainer/Red".group
	var cor = group.get_pressed_button().modulate
	
	WorldEnv.player_color = cor
	WorldEnv.player_name = $"../PlayerName".text
	WorldEnv.difficult_level = 1 + ($"../OptionButton" as OptionButton).selected
	
	get_tree().change_scene("res://Scenes/Cenário.tscn")

