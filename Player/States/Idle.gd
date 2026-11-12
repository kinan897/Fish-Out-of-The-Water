extends PlayerState

func Enter(msg: StateMessage):
	Player.CoyoteTimer = Player.CoyoteTime
	Player.velocity = Vector2.ZERO
	if (msg is PlayerStateMessage):
		if msg.SkipAnimation == false:
			return
	Player.Sprite.play("Idle")
	
func PhysicsUpdate(delta: float):
	if (Input.is_action_pressed("drink")):
		state_machine.TransitionTo("Drink")
	if (!Player.is_on_floor()):
		state_machine.TransitionTo("Air", PlayerStateMessage.new())
		return
		
	if Player.EnableJumpBuffer:
		if Player.JumpBuffer > 0.0:
			var msg = PlayerStateMessage.new(); msg.DoJump = true
			state_machine.TransitionTo("Air", msg)
			Player.JumpBuffer = 0.0
			return
	else:
		if Input.is_action_just_pressed("jump"):
			var msg = PlayerStateMessage.new(); msg.DoJump = true
			state_machine.TransitionTo("Air", msg)
			Player.JumpBuffer = 0.0
			return
	
	if Input.is_action_pressed("left") || Input.is_action_pressed("right"):
		if sign(Player.DirectionalInput.call().x) == -sign(Player.FacingDirection):
			pass
			#Player.Sprite.play("Turn")
		else: 
			pass
			#Player.Sprite.play("IdleToRun")
		var msg = PlayerStateMessage.new(); msg.SkipAnimation = true
		state_machine.TransitionTo("Run", msg)
		return
	
	if Input.is_action_just_pressed("dash") && Player.CurrentDashes < Player.DashLimit:
		state_machine.TransitionTo("Dash", PlayerStateMessage.new())
		return
