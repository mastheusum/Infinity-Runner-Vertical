extends Node2D

export var stream : AudioStream


func _ready():
	GlobalAudio.set_sound(stream)
