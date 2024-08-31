extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	if Global.passed:
		$winner.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_regular_pressed():
	Global.regular_mode = true
	get_tree().change_scene_to_file("res://Scenes/tutorial.tscn")


func _on_difficult_pressed():
	if Global.passed:
		Global.answer_array.clear()
		Global.player_answer_array.clear()
		Global.hard_mode = true
		Global.regular_mode = false
		get_tree().change_scene_to_file("res://Scenes/levels/main.tscn")





func _on_difficult_mouse_entered():
	$hm.show()


func _on_difficult_mouse_exited():
	$hm.hide()
