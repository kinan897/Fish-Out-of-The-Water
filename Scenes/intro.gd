extends Node2D

var index = 1

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack") || Input.is_action_just_pressed("jump"):
		
		index+=1
		if index ==1:
			$"1".visible = true
		if index ==2:
			$"2".visible = true
		if index ==3:
			$"3".visible = true
		if index ==4:
			get_tree().change_scene_to_file("res://Scenes/start.tscn")
		
