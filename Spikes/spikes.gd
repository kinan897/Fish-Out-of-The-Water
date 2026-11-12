extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if Global.player.get_node("StateMachine")._state.name != "Hurt":
		Global.player.global_position = Global.lastSafeFloor
		#var dif = (body.global_position - global_position).normalized()
		Global.player.global_position = Global.lastSafeFloor
		Global.hit(1, Vector2.ZERO)
	
