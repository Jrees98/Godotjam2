extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	var keys = Global.sprite_paths.keys()
	var random_index = randi_range(0, keys.size() - 1)
	var random_key = keys[random_index]
	
	#load sprite and set position at marker (on top of pedestal)
	var selected_sprite = load(random_key)
	$Item.texture = selected_sprite
	var marker_position = $ItemPosition.position
	$Item.position = marker_position
	
	Global.answer_array += [Global.sprite_paths[random_key]]
	Global.sprite_paths.erase(random_key)
	print(Global.answer_array)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
