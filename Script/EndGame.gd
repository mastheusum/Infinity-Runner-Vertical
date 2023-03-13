extends Node2D

const FILE_NAME = "user://higscores.save"

var config = ConfigFile.new()
var err = config.load(FILE_NAME)

var new_player = false
var player = {
	"name" : "",
	"score" : 0
}

class CustomSorter:
	static func sort_descending(a, b):
		return int(a[1]) > int(b[1])

func _ready():
	$CurrentPlayer.modulate = WorldEnv.player_color as Color
	$CurrentPlayer.bbcode_text = "[center]" + player["name"] + "    " + str(player["score"])
	$Scores.bbcode_text = "[center]"
	var rank = Array()
	var rank_fields = read()
	for key in rank_fields:
		rank.append([key, rank_fields[key]])
	print_rank(rank)

func save(data : Array):
	for field in data:
		config.set_value("highscores", field[0], field[1])
	config.save(FILE_NAME)
	
func read() -> Dictionary:
	var result = Dictionary()
	
	for key in config.get_section_keys("highscores"):
		result[key] = config.get_value("highscores", key)
	
	return result

func print_rank(rank : Array):
	var custom_rank = rank.duplicate()
	rank.append([player['name'], player["score"]])
	custom_rank.append(["[color="+ (WorldEnv.player_color as Color).to_html() +"]"+player['name'], str(player["score"]) + "[/color]"])
	
	rank.sort_custom(CustomSorter, "sort_descending")
	custom_rank.sort_custom(CustomSorter, "sort_descending")
	for i in range(len(custom_rank)):
		$Scores.bbcode_text += custom_rank[i][0] + ": " + str(custom_rank[i][1]) + "\n"
	if new_player:
		save(rank)

