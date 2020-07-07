extends Node

const FILE_NAME = "user://higscores.save"

var config = ConfigFile.new()
var err = config.load(FILE_NAME)

func save(data):
	config.set_value("player", "name", data["name"])
	config.set_value("scores", "score", data["score"])
	config.save(FILE_NAME)
	
func read():
	var player = {
		"name" : config.get_value("player", "name"),
		"score": config.get_value("scores", "score")
	}
	return player
