extends Node

var round_number = 1
var sprite_paths = {
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
var round_started
var sound_playback_position : float = 0.0
var passed : bool
var current_level := 1
var player_answer_array := []
var answer_array := []

var total_time : int
#difficulty select
var regular_mode : bool
var hard_mode : bool
var item_counter := 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
