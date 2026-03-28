extends Node3D

@onready var player = $Player2
@onready var spawns = $Spawns
@onready var navigation_region = $NavigationRegion3D

var BASE_base_speed = 7.0
var BASE_jump_velocity = 4.5
var BASE_sprint_speed = 10.0
var BASE_freefly_speed = 25.0

var enemy = load("res://Scenes/Enemy.tscn")
var  instance

func _ready() -> void:
	randomize()
	
func _input(event: InputEvent) -> void:
	if event.is_action("item_use"):
		if (Global.selected_item == 3):
			$nuke.start_fall()
			$nukes.play()
		if (Global.selected_item == 2):
			$slow.play()
			$UID.stop_timer()
			await get_tree().create_timer(20).timeout
			$UID.launch_timer()
			$slow.stop()
		if (Global.selected_item == 1):
			$fast.play()
			Global.base_speed = BASE_base_speed * 3.0
			Global.jump_velocity = BASE_jump_velocity * 3.0
			Global.sprint_speed = BASE_sprint_speed * 2.0
			Global.freefly_speed = BASE_freefly_speed * 1.2
			await get_tree().create_timer(12.30).timeout
			Global.base_speed = BASE_base_speed
			Global.jump_velocity = BASE_jump_velocity
			Global.sprint_speed = BASE_sprint_speed
			Global.freefly_speed = BASE_freefly_speed
		$UID.clear_item()
		
func _process(delta: float) -> void:
	if (Global.coins == 3):
		$UID.set_random_item()
		Global.coins = 0

func _physics_process(delta: float) -> void:
	get_tree().call_group("enemies", "update_target_location", player.global_transform.origin)
	
func _get_randon_child(parent_node):
	var random_id = randi() % parent_node.get_child_count()
	return parent_node.get_child(random_id)


func _on_zombie_spawn_timer_timeout() -> void:
	var spawn_point = _get_randon_child(spawns).global_position
	instance = enemy.instantiate()
	instance.position = spawn_point
	navigation_region.add_child(instance)


func _on_death_zone_body_entered(body: Node3D) -> void:
	if "Player" in body:
		$UID.time_left = 0
