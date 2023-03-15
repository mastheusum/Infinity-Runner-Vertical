extends KinematicBody2D

var base_move_speed = 250
var dificult_scale = 0.2

func _process(delta):
	move_and_slide( 
		Vector2.DOWN * (
			base_move_speed + 
			base_move_speed * dificult_scale * WorldEnv.difficult_level
		) 
	)

