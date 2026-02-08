extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.base_speed = 7.0
	Global.jump_velocity = 4.5
	Global.sprint_speed = 10.0
	Global.freefly_speed = 25.0
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$Control/Panel/Label/tomatoes.text = str(Global.totalcoins)
	$Control/Panel/Label2/kill.text = str(Global.kill)
	$Control/Panel/Label3/total.text = str(Global.kill * (Global.totalcoins + 1))
	Global.coins = 0
	Global.totalcoins = 0
	Global.kill = 0
	Global.selected_item = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://main.tscn")


func _on_button_2_pressed() -> void:
	get_tree().quit()
