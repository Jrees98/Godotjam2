extends Area2D

@export var item_sprite := Texture2D
@export var item_name = ""
signal item_touched

func _ready():
	$ItemSprite.texture = item_sprite
	var marker_position = $ItemPosition.position
	$ItemSprite.position = marker_position



func _on_body_entered(body):
	var item = item_name
	if item not in Global.player_answer_array:
		Global.player_answer_array += [item_name]
	print(Global.player_answer_array)
