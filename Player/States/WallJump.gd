extends PlayerState

func Enter(msg: StateMessage):
	Player.WallJumpTimer = Player.WallJumpTime
	#Player.Sprite.play("WallJump")
	Player.Sprite.play("Jump")
	Player.velocity = Vector2(
		sign(Player.FacingDirection) * Player.WallJumpSpeed * cos(Player.WallJumpAngleInDegrees * PI / 180),
		-Player.WallJumpSpeed * sin(Player.WallJumpAngleInDegrees * PI / 180)
	)

func PhysicsUpdate(delta: float):
	if Player.WallJumpTimer <= 0 or !Input.is_action_pressed("jump"):
		state_machine.TransitionTo("Air")
		return
