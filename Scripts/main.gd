extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_swim_suit_item_touched(item):
	print(item)


func _on_check_pressed():
	if Global.answer_array == Global.player_answer_array:
		Global.player_answer_array = []
		Global.answer_array = []
		Global.current_level += 1
		var scene_name = "res://Scenes/levels/level" + str(Global.current_level) + ".tscn"
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
		get_tree().change_scene_to_file(scene_name)
		Global.item_counter = 0
		print("Correct!")
	else:
		print("Incorrect")
		Global.player_answer_array = []
		Global.item_counter = 0


func _on_reload_pressed():
	get_tree().reload_current_scene()
	
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
	Global.answer_array = []
