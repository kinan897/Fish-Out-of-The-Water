extends Area2D

var player_in = false

func _process(delta: float) -> void:
	if player_in:
		if  Input.is_action_just_pressed("up") || Input.is_action_just_pressed("attack"):
			get_tree().change_scene_to_file("res://Scenes/factory_destroy.tscn")

func _on_body_entered(body: Node2D) -> void:
	player_in = true


func _on_body_exited(body: Node2D) -> void:
	player_in = false
