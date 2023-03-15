extends RigidBody2D

var points = 0

var direction = Vector2(0,0)
var impulse_scale = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	self.modulate = WorldEnv.player_color
	self.gravity_scale = 0
	self.weight = 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _integrate_forces(state):
	look_at(get_global_mouse_position())
	self.apply_central_impulse(direction * impulse_scale)
	
	var x_transform = state.get_transform()
	if x_transform.origin.x > get_viewport_rect().size.x:
		x_transform.origin.x = get_viewport_rect().size.x
	elif x_transform.origin.x < 0:
		x_transform.origin.x = 0
		
	if x_transform.origin.y > get_viewport_rect().size.x:
		x_transform.origin.y = get_viewport_rect().size.x
	elif x_transform.origin.y < 0:
		x_transform.origin.y = 0
	state.set_transform(x_transform)

func _physics_process(delta):
	get_input()
	if len(get_colliding_bodies()) > 0:
		WorldEnv.player_score = points
		get_tree().change_scene("res://Scenes/EndGame.tscn")
		
func get_input():
	if Input.is_action_pressed("ui_direction"):
		direction = Vector2(1,0).rotated(rotation)
	else:
		direction = Vector2.ZERO

func _process(delta):
	points += delta * WorldEnv.difficult_level

func _on_TimeCount_timeout():
	points += 1
