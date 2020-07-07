extends Node2D

const FILE_NAME = "user://higscores.save"

var config = ConfigFile.new()
var err = config.load(FILE_NAME)

var player = {
	"name" : "",
	"score" : 0
}

func _ready():
	get_child(1).text = player["name"] + "    " + str(player["score"])
	var rank = generate_rank()
	print_rank(rank)
	print(rank)
	save(rank)

func save(data):
	for i in range(len(data[0])):
		config.set_value("highscores", data[0][i], data[1][i])
	config.save(FILE_NAME)
	
func read():
	var result = []
	var values = []
	var keys = []
	
	for i in config.get_section_keys("highscores"):
		keys.append(i)
	
	if len(keys) > 0:
		for i in keys:
			values.append( config.get_value("highscores", i) )
	
	result.append(keys)
	result.append(values)
	
	return result
	
func generate_rank():
	var current_rank = read()
	if len(current_rank[0]) > 0:
		current_rank = bubble_sort_duplo(current_rank)
		for i in range(len(current_rank[1])):
			if current_rank[1][i] < player["score"]:
				current_rank[0].insert(i, player["name"])
				current_rank[1].insert(i, player["score"])
				
		if len(current_rank[1]) > 10:
			current_rank[0].pop_back()
			current_rank[1].pop_back()
	else:
		current_rank[0].append(player["name"])
		current_rank[1].append(player["score"])
			
	return current_rank

func print_rank(rank):
	for i in range(len(rank[0])):
		self.get_child(3).text += rank[0][i] + " " + str(rank[1][i]) + "\n"
		
func bubble_sort_duplo(array):
	var tmp
	for i in range(len(array[0])):
		for j in range(i):
			if array[1][j] < array[1][i]:
				tmp = array[0][j]
				array[0][j] = array[0][i]
				array[0][i] = tmp
				
				tmp = array[1][j]
				array[1][j] = array[1][i]
				array[1][i] = tmp
	return array
