extends AudioStreamPlayer

func set_sound(stream : AudioStream, speed : float = 1):
	GlobalAudio.stream = stream
	$Tween.interpolate_property(
		self, "pitch_scale", pitch_scale, speed,
		2, Tween.TRANS_LINEAR, Tween.EASE_OUT
	)
	$Tween.start()
	GlobalAudio.play()
	
