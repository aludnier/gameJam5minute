extends Control
@onready var item_texture := $Item/AspectRatioContainer/TextureRect

var item_textures := {
	1: preload("res://resources/items/item1.png"),
	2: preload("res://resources/items/item2.png"),
	3: preload("res://resources/items/item3.png")
}

func set_random_item():
	var item_id := randi_range(1, 3)

	item_texture.texture = item_textures[item_id]
	item_texture.visible = true

	Global.selected_item = item_id

func clear_item():
	item_texture.texture = null
	item_texture.visible = false

	Global.selected_item = 0
	
@onready var time_label := $Panel/TimeLabel

@export var time_left := 300.0
var running := true

func stop_timer():
	running = false

func update_label():
	var minutes := int(time_left) / 60
	var seconds := int(time_left) % 60
	time_label.text = "%02d:%02d" % [minutes, seconds]

func _on_timer_finished():
	get_tree().change_scene_to_file("res://tiitleend.tscn")


func _ready():
	$tomatos/count.text = str(Global.coins)

func _process(delta: float) -> void:
	$tomatos/count.text = str(Global.coins)
	if running:
		time_left -= delta
		if time_left <= 0:
			time_left = 0
			running = false
			_on_timer_finished()
		update_label()
	
