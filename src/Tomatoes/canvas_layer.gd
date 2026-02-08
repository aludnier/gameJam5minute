extends CanvasLayer

@onready var rect := $ColorRect

var fade_speed := 1.2
var fading := false

func start_white_fade():
	rect.color.a = 1.0
	fading = true

func _process(delta):
	if fading:
		rect.color.a -= fade_speed * delta
		if rect.color.a <= 0.0:
			rect.color.a = 0.0
			fading = false
