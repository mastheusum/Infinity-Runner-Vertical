extends Node2D

var rand = RandomNumberGenerator.new()
var bloco = preload("res://Instantiable/Bloco.tscn")
var triangulo = preload("res://Instantiable/triangulo.tscn")

var dificuldade = 0.5
var pointsToNextLevel = 10

func _process(delta):
	if self.get_child(2).points == pointsToNextLevel:
		dificuldade -= (dificuldade / 10)
		self.get_child(3).wait_time -= (get_child(3).wait_time / 10)
		pointsToNextLevel += (pointsToNextLevel + 10)
	
	self.get_child(1).get_child(0).text = "Points: " + str(self.get_child(2).points)
	
	
func _on_Spawn_Blocos_timeout():
	var newScales = rand.randf_range(0, 1 - dificuldade)
	var complementScales = 1 - dificuldade - newScales
	var cor = Color(rand.randf_range(0, 1),rand.randf_range(0, 1),rand.randf_range(0, 1), 1)
	
	var newBloco1 = bloco.instance()
	newBloco1.modulate = cor
	newBloco1.position.x = 500 * newScales / 2
	newBloco1.position.y = -100
	newBloco1.get_child(0).scale.x = newScales
	newBloco1.get_child(1).scale.x = newScales
	self.add_child(newBloco1)
	
	var newBloco2 = bloco.instance()
	newBloco2.modulate = cor
	newBloco2.position.x = 500 - (500 * complementScales / 2)	
	newBloco2.position.y = -100
	newBloco2.get_child(0).scale.x = complementScales
	newBloco2.get_child(1).scale.x = complementScales
	self.add_child(newBloco2)
	

