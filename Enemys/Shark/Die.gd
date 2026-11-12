extends State

var dialogue = preload("res://NPC/dialogue_guy.tscn")

func Enter(msg: StateMessage) -> void:

	var x: DialogueGuy = dialogue.instantiate()
	x.dialogue.clear()
	x.dialogue.append("Press Right Trigger to Dash")
	x.dialogue.append("On keyboard, press Right Shift to Dash")
	x.dialogue.append("You can dash across large areas!")
	x.dialogue.append("maybe backtrack???")
	x.dialogue.append("")
	x.global_position = (get_parent().get_parent().global_position + Vector2(0, 0))
	get_parent().get_parent().get_parent().add_child(x)
	
	Global.player.DashLimit = 1
	Global.boss_music = false
	state_machine.get_parent().queue_free()
