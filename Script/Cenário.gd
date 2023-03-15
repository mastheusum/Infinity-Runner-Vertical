extends Node2D

var level_hit_cap = 3
var level_hit = 1
var spawn_time_base := 1.0

func _set_wait_spawner():
	$"Spawn Blocos".wait_time = spawn_time_base - WorldEnv.difficult_level * spawn_time_base / 5

func _ready():
	randomize()
	_set_wait_spawner()

func _process(delta):
	$GUI/Label.bbcode_text = "[center]Points: " + str(int($Player.points))

func _on_Spawn_Blocos_timeout():
	var cor = Color(rand_range(0, 1),rand_range(0, 1),rand_range(0, 1), 1)
	$ObjectPoller.new_instance(randi() % 500 - 282, cor)

func end_stage():
	if level_hit < level_hit_cap:
		print("-> Level++")
		level_hit += 1
		$"Spawn Blocos".stop()
		$"Spawn Blocos".wait_time *= 0.9
		$"Spawn Blocos".start()
		$ObjectPoller.restart_queue()
	else:
		print(">>> Dificult++")
		level_hit = 1
		WorldEnv.difficult_level += 1
		_set_wait_spawner()
		$ObjectPoller.start_queue()
	
