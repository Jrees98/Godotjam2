extends Node2D

@onready var item_generator_scene = preload("res://Scenes/item_generator.tscn")
@onready var hard_mode_collision = preload("res://Scenes/hard_mode_collision.tscn")
var round_times = {
	1:10,
	2:12,
	3:15,
	4:18,
	5:20,
	6:22,
	7:25,
	8:28,
}
var this_round_time : int
var hard_mode_position : Vector2
var hard_mode_barrier : bool
var area_tracker : int

func _on_p_pressed():
	print("Hi")
func _ready():
	$Level.text = "Level:\n" + str(Global.round_number) + " of 8"
	hard_mode_position = Vector2(0,-75)
	area_tracker = 0
	hard_mode_barrier = false
	$Player/Camera2D/CanvasLayer.hide()
	start_level()
	if Global.regular_mode:
		$CountDown.text = str(round_times[Global.round_number])
	else:
		$CountDown.text = str(Global.total_time)
	$RoundTimer.wait_time = round_times[Global.round_number]
	this_round_time = round_times[Global.round_number]




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("skip_level"):
		Global.player_answer_array = Global.answer_array

func _on_swim_suit_item_touched(item):
	print(item)

func start_level():
	Global.hard_mode = true
	Global.round_started = false
	$Transition.play("fade_in")
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
		

func _on_check_pressed():
	if Global.round_number == 8 and Global.answer_array == Global.player_answer_array and Global.regular_mode == true:
		Global.passed = true
		get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")
		return
		
	if Global.round_number == 8 and Global.answer_array == Global.player_answer_array and Global.hard_mode == true:
		$UI.show()
		$UI/RoundSummary2.text = "Total time: " + str(Global.total_time)
		return

	if Global.answer_array == Global.player_answer_array and Global.round_number != 8:
		Global.player_answer_array.clear()
		Global.answer_array.clear()
		Global.item_counter = 0
		Global.round_number += 1
		get_tree().reload_current_scene()
		print("Correct!")
	else:
		print("Incorrect")
		Global.player_answer_array.clear()
		Global.answer_array.clear()
		Global.item_counter = 0
		get_tree().reload_current_scene()


#func _on_reload_pressed():
	#Global.player_answer_array = []
	#get_tree().get_nodes_in_group("pedestals")
	


#ROUND TIMER TIMEOUT IE: ROUND LOST
func _on_round_timer_timeout():
	Global.player_answer_array.clear()
	Global.answer_array.clear()
	Global.item_counter = 0
	$Transition.play("fade_out")
	await $Transition.animation_finished 
	get_tree().reload_current_scene()

#START ROUND TIMER HERE
var times_entered : int
func _on_start_timer_body_entered(body):
	if body.is_in_group("player"):
		area_tracker += 1
		Global.round_started = true
		if Global.regular_mode:
			$RoundTimer.start()
		$CountDownTimer.start()
		if Global.hard_mode and area_tracker > 2:
			var instance = hard_mode_collision.instantiate()
			var position_node = instance.get_node("Node2D")
			position_node.position = hard_mode_position
			add_child(instance)
			print(position_node)
		print(area_tracker)
		print(Global.hard_mode)

#TIMER TO COUNT DOWN 1 SECOND AT A TIME
func _on_count_down_timer_timeout():
	if Global.regular_mode:
		this_round_time -= 1
		if this_round_time == 0:
			$CountDownTimer.stop()
		$CountDown.text = str(this_round_time)
	elif Global.hard_mode:
		Global.total_time += 1
		$CountDown.text = str(Global.total_time)



func _on_close_pressed():
	$UI.visible = false

