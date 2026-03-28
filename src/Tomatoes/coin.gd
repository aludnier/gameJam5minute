extends Area3D

const ROT_SPEED = 0.2

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	rotate_y(deg_to_rad(ROT_SPEED))

func _respawn_coin() -> void :
	%MeshInstance3D.visible = true
	set_collision_layer_value(3, true)
	set_collision_mask_value(1, true)


func _on_body_entered(body: Node3D) -> void:
	if "PLAYER" in body:
		print(Global.coins)
		Global.coins += 1
		Global.totalcoins += 1
		%MeshInstance3D.visible = false
		$collect.play()
		set_collision_layer_value(3, false)
		set_collision_mask_value(1, false )
		await get_tree().create_timer(20).timeout
		_respawn_coin()
