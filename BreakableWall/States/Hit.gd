extends State

func Enter(msg: StateMessage) -> void:
	state_machine.get_parent().hits -= 1
	if (state_machine.get_parent().hits <= 0):
		state_machine.TransitionTo("Broken")
	else:
		state_machine.TransitionTo("Idle")
