extends PlayerState

func Enter(msg: StateMessage) -> void:
	Player.velocity = Vector2.ZERO
	
func PhysicsUpdate(delta: float) -> void:
	if !Player.Sprite.is_playing():
		Player.global_position = Global.lastRespawn.global_position
		state_machine.TransitionTo("Idle", PlayerStateMessage.new())
