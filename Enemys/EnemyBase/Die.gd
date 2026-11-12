extends State

func Enter(msg: StateMessage) -> void:
	state_machine.get_parent().queue_free()
