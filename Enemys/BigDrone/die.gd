extends State

var self_destruct = preload("res://Scenes/self_destruct.tscn")

func Enter(msg: StateMessage) -> void:
	var x = self_destruct.instantiate()
	x.global_position = get_parent().get_parent().global_position
	get_parent().get_parent().get_parent().add_child(x)
	state_machine.get_parent().queue_free()
