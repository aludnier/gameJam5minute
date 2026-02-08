extends Area3D

@export var fall_speed := 0.74

var falling := false
var start_position: Vector3

func _ready():
	start_position = Vector3(0.0, 5405.358, 0.0)
	visible = false
	set_process(false)


func start_fall():
	global_position = Vector3(0.0, 5405.358, 0.0)
	visible = true
	falling = true
	set_process(true)

func _process(delta):
	if falling:
		translate(Vector3(0, -fall_speed * delta, 0))

func _on_body_entered(body):
	falling = false
	set_process(false)

	var rect := $ScreenFX/ColorRect
	$ScreenFX.visible = true
	rect.color.a = 1.0

	visible = false
	while rect.color.a > 0.0:
		rect.color.a -= 0.02
		await get_tree().create_timer(1.0).timeout

	global_position = Vector3(0.0, 5405.358, 0.0)

	
