extends Node2D

@onready var item_generator_scene = preload("res://Scenes/item_generator.tscn")
# Called when the node enters the scene tree for the first time.

var dialogue_counter : int
var path : bool
func _ready():
	dialogue_counter = 0
	start_level()
	$Player/Camera2D/CanvasLayer/ColorRect/monkey_text.text = "Welcome friend. Let's teach you the rules of the game."
	get_tree()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func start_level():
	
	Global.round_started = false
	Global.sprite_paths = {
	"res://Assets/beachball.png": "beachball",
	"res://Assets/coconut.png": "coconut",
	"res://Assets/pineapple.png": "pineapple",
	"res://Assets/swimsuit.png": "swimsuit",
	"res://Assets/bucket.png": "bucket",
	"res://Assets/crab.png": "crab",
	"res://Assets/fish.png": "fish",
	"res://Assets/icecream.png": "icecream",
	"res://Assets/sunscreen.png": "sunscreen",
	"res://Assets/umbrella.png" : "umbrella",
	}
	var ycoord = -193
	var positions = {
		1: [
			Vector2(-16,ycoord),
			Vector2(4,ycoord),
			Vector2(24,ycoord),
		],
		2: [
			Vector2(-16,ycoord),
			Vector2(4,ycoord),
			Vector2(24,ycoord),
			Vector2(44,ycoord)
		],
		3: [
			Vector2(-36,ycoord),
			Vector2(-16,ycoord),
			Vector2(4,ycoord),
			Vector2(24,ycoord),
			Vector2(44,ycoord)
		],
		4: [
			Vector2(-36,ycoord),
			Vector2(-16,ycoord),
			Vector2(4,ycoord),
			Vector2(24,ycoord),
			Vector2(44,ycoord),
			Vector2(64,ycoord),
		],
		5: [
			Vector2(-56,ycoord),
			Vector2(-36,ycoord),
			Vector2(-16,ycoord),
			Vector2(4,ycoord),
			Vector2(24,ycoord),
			Vector2(44,ycoord),
			Vector2(64,ycoord),
		],
		6: [
			Vector2(-56,ycoord),
			Vector2(-36,ycoord),
			Vector2(-16,ycoord),
			Vector2(4,ycoord),
			Vector2(24,ycoord),
			Vector2(44,ycoord),
			Vector2(64,ycoord),
			Vector2(84,ycoord),
		],
		7: [
			Vector2(-76,ycoord),
			Vector2(-56,ycoord),
			Vector2(-36,ycoord),
			Vector2(-16,ycoord),
			Vector2(4,ycoord),
			Vector2(24,ycoord),
			Vector2(44,ycoord),
			Vector2(64,ycoord),
			Vector2(84,ycoord),
		],
		8: [
			Vector2(-76,ycoord),
			Vector2(-56,ycoord),
			Vector2(-36,ycoord),
			Vector2(-16,ycoord),
			Vector2(4,ycoord),
			Vector2(24,ycoord),
			Vector2(44,ycoord),
			Vector2(64,ycoord),
			Vector2(84,ycoord),
			Vector2(104,ycoord)
		],
	}
	
	var level_position = positions[Global.round_number]
	for position in level_position:
		var instance = item_generator_scene.instantiate()
		instance.position = position
		add_child(instance)
		


func _on_close_dialogue_pressed():
	dialogue_counter += 1
	if dialogue_counter == 1:
		$Player/Camera2D/CanvasLayer/ColorRect/monkey_text.text = "The goal is to remember the order of the items that are shown on stage."
	elif dialogue_counter == 2:
		$Player/Camera2D/CanvasLayer/ColorRect/monkey_text.text = "Use WASD or the arrow keys to move."
	elif dialogue_counter == 3:
		$Player/Camera2D/CanvasLayer/ColorRect/monkey_text.text = "Walk north to find the stage."
	elif dialogue_counter == 4:
		get_tree().paused = false
		$Player/Camera2D/CanvasLayer.hide()
	elif dialogue_counter == 5:
		get_tree().paused = false
		$Player/Camera2D/CanvasLayer/ColorRect/monkey_text.text = "Just don't take too long or you'll run out of time!"
	elif dialogue_counter == 6:
		get_tree().paused = false
		$Player/Camera2D/CanvasLayer/ColorRect/monkey_text.text = "Run back south and touch the pillars in order."
	elif dialogue_counter == 7:
		$Player/Camera2D/CanvasLayer/ColorRect/monkey_text.text = "Click the check button when you are done. This button is also used..."
	elif dialogue_counter == 8:
		$Player/Camera2D/CanvasLayer/ColorRect/monkey_text.text = "reset the level if you mess up."
	elif dialogue_counter == 9:
		$Player/Camera2D/CanvasLayer/ColorRect/monkey_text.text = "Click the check button to start the real game!"


func _on_start_timer_body_entered(body):
	if body.is_in_group("player"):
		Global.round_started = true
		dialogue_counter = 3
		$StartTimer.queue_free()
		$Player/Camera2D/CanvasLayer.show()
		$Player/Camera2D/CanvasLayer/ColorRect/monkey_text.text = "As soon as you step onto this path, the timer will start"
		get_tree().paused = true


func _on_start_stage_body_entered(body):
	if body.is_in_group("player"):
		$start_stage.queue_free()
		$Player/Camera2D/CanvasLayer.show()
		$Player/Camera2D/CanvasLayer/ColorRect/monkey_text.text = "Don't forget the order! Feel free to come back to the stage if you forget."
		get_tree().paused = true


func _on_check_pressed():
	if dialogue_counter >= 8:
		get_tree().change_scene_to_file("res://Scenes/levels/main.tscn")
