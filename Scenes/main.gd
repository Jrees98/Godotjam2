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
