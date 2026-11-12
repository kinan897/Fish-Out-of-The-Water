extends PlayerState 

func Enter(msg: StateMessage):
	if (msg is PlayerStateMessage):
		if msg.SkipAnimation == false:
			return
	Player.Sprite.play("Run")

func PhysicsUpdate(delta: float):
	if not $WalkSound.playing:
		$WalkSound.play()
	
	
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
	
	if is_zero_approx(Player.DirectionalInput.call().x):
		#Player.Sprite.play("RunToIdle")
		var msg = PlayerStateMessage.new()
		msg.SkipAnimation = true
		state_machine.TransitionTo("Idle", msg)
		return
		
	if !Player.is_on_floor():
		state_machine.TransitionTo("Air")
	
	if (Input.is_action_just_pressed("dash") and Player.CurrentDashes < Player.DashLimit):
		state_machine.TransitionTo("Dash")
	
	if Player.DirectionalInput.call().x != 0:
		Player.FacingDirection = sign(Player.DirectionalInput().x)
		
	Player.velocity = Vector2(Player.GroundedMaxSpeed * sign(Player.DirectionalInput.call().x), Player.velocity.y)
