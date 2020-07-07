extends RigidBody2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if position.y > get_parent().get_viewport().size.y:
		get_parent().remove_child(self)
	
	var collision_info = get_colliding_bodies()
	if len(collision_info) > 0:
		print("bateu")
	
