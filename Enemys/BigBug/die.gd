extends State

var dialogue = preload("res://NPC/dialogue_guy.tscn")

func Enter(msg: StateMessage) -> void:
	Global.player.EnableWallSlideAndWallJump = true
	
	var x: DialogueGuy = dialogue.instantiate()
	x.dialogue.clear()
	x.dialogue.append("You can now wall jump!")
	x.dialogue.append("You can reach places you couldn't before!")
	x.dialogue.append("like that wall you fell down")
	x.dialogue.append("")
	x.global_position = (get_parent().get_parent().global_position + Vector2(0, 0))
	get_parent().get_parent().get_parent().add_child(x)
	
	state_machine.get_parent().queue_free()
