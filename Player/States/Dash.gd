extends PlayerState

var _dashDir: int

func Enter(msg: StateMessage):
	$DashSound.play()
	Player.CurrentDashes += 1
	Player.DashTimer = Player.DashTime
	
	if msg is PlayerStateMessage:
		if msg.DashDir != 0:
			_dashDir = msg.DashDir
	else:
		if is_zero_approx(Player.DirectionalInput().x):
			_dashDir = Player.FacingDirection
		else:
			_dashDir = sign(Player.DirectionalInput().x)
	
	Player.FacingDirection = _dashDir
	#Player.Sprite.play("Dash")
	Player.velocity = Vector2(_dashDir * Player.DashSpeed, 0)

func PhysicsUpdate(delta: float):
	if Player.DashTimer <= 0:
		if Player.is_on_floor():
			if is_zero_approx(Player.DirectionalInput().x):
				#Player.Sprite.play("DashToIdle")
				var msg = PlayerStateMessage.new(); msg.SkipAnimation = true
				state_machine.TransitionTo("Idle", msg)
				return
			else:
				#Player.Sprite.play("IdleToRun")
				var msg = PlayerStateMessage.new(); msg.SkipAnimation = true
				state_machine.TransitionTo("Run", msg)
				return
		state_machine.TransitionTo("Air")
		return
	
	if Input.is_action_just_pressed("jump"):
		Player.DashTimer = 0.0
		var msg = PlayerStateMessage.new(); msg.DoJump = true
		state_machine.TransitionTo("Air", msg)
		return
		
func Exit():
	Player.velocity.x = 0
