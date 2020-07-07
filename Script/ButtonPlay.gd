extends TextureButton

var next_scene = preload("res://Scenes/Cenário.tscn")

func _pressed():
	var cor = Color(0, 0, 0)
	for i in range(2):
		for j in range(4):
			var box = self.get_parent().get_child(1).get_child(0).get_child(i).get_child(j)
			if (box.pressed):
				cor = box.modulate
				
	var cena = next_scene.instance()
	cena.get_child(2).modulate = cor
	cena.get_child(2).player_name = self.get_parent().get_child(3).text
	self.get_parent().get_parent().add_child(cena)
	self.get_parent().get_parent().remove_child(self.get_parent())
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
