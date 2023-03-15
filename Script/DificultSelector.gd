extends OptionButton

export var dificult = {
	'Easy' : 1,
	'Medium' : 2,
	'Hard' : 3,
	'Very Hard' : 4
}

func _ready():
	for key in dificult:
		add_item(key, dificult[key])

