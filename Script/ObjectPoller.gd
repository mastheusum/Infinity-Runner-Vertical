extends Node2D

var bloco = preload("res://Instantiable/Bloco.tscn")
var queue := Array()
var free_queue_size := 0
var _scale_queue_size = 5

signal queue_free

func _ready():
	start_queue()
	connect("queue_free", get_parent(), "end_stage")

func start_queue():
	var clone = null
	free_queue_size = WorldEnv.difficult_level * _scale_queue_size
	for i in free_queue_size:
		clone = bloco.instance()
		add_child(clone)
		queue.append(clone)
	restart_queue()

func restart_queue():
	free_queue_size = WorldEnv.difficult_level * _scale_queue_size
	for clone in queue:
		clone.position = self.position
		clone.set_process(false)

func new_instance(x_pos : float, color : Color):
	var clone = queue.pop_front()
	clone.position.x = x_pos
	clone.modulate = color
	queue.append(clone)
	clone.set_process(true)

func _on_Area2D_body_entered(body : Node):
#	print(free_queue_size)
	if body.is_in_group("Block"):
		body.set_process(false)
		free_queue_size -= 1
		if free_queue_size <= 0:
			emit_signal("queue_free")

func set_free_queue_size(value):
	free_queue_size = value
