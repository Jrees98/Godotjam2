extends Area2D

@export var item_sprite := Texture2D
@export var item_name = ""
signal item_touched

func _ready():
	$ItemSprite.texture = item_sprite
	var marker_position = $ItemPosition.position
	$ItemSprite.position = marker_position
	$".".add_to_group("pedestals")



func _on_body_entered(body):
	var item = item_name
	if item not in Global.player_answer_array and Global.round_started:
		Global.player_answer_array += [item_name]
		Global.item_counter += 1
		$Label.text = str(Global.item_counter)
		$AnimationPlayer.play("floating")
	print(Global.player_answer_array)
