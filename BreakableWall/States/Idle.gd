extends State

func Enter(msg: StateMessage):
	pass

func _on_hitbox_area_entered(area: Area2D) -> void:
	if (area.is_in_group("Hitbox")):
		state_machine.TransitionTo("Hit")
