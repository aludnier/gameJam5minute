extends Node3D

func _input(event: InputEvent) -> void:
	if event.is_action("item_use"):
		if (Global.selected_item == 3):
			$nuke.start_fall()
			$nukes.play()
		if (Global.selected_item == 2):
			$slow.play()
		if (Global.selected_item == 1):
			$fast.play()
		$UID.clear_item()

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (Global.coins == 1):
		$UID.set_random_item()
		Global.coins = 0
	pass
