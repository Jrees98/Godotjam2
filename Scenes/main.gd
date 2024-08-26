extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_swim_suit_item_touched(item):
	print(item)


func _on_check_pressed():
	if Global.answer_array == Global.player_answer_array:
		print("Correct!")
	else:
		print("Incorrect")
		Global.player_answer_array = []


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
	"res://Assets/sunscreen.png": "sunscreen"
	}
	Global.answer_array = []
