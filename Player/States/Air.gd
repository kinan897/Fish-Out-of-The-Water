extends PlayerState

enum AirState{
	Fall,
	Jump
}

var _airState: AirState = AirState.Fall
var _stoppedJump: bool

func Enter(msg: StateMessage):
	_stoppedJump = false
	
	if msg is PlayerStateMessage:
		if msg.DoJump == true and Player.CurrentJumps < Player.Jumps:
			$JumpSound.play()
			Player.CurrentJumps += 1
			_airState = AirState.Jump
			Player.velocity.y = -Player.JumpVelocity
			
			#if Player.CurrentJumps == 2:
				#Player.Sprite.play("DoubleJump")
			#else:
				#Player.Sprite.play("Jump")
			Player.Sprite.play("Jump")
			Player.Sprite.frame = 0

func PhysicsUpdate(delta: float):
	if Player.DirectionalInput.call().x != 0 and sign(Player.DirectionalInput.call().x) != Player.FacingDirection:
		Player.FacingDirection = sign(Player.DirectionalInput.call().x)
	
	
	
	if Player.velocity.y >= 0:
		if _airState != AirState.Fall:
			_airState = AirState.Fall
			if Player.CurrentJumps == 0:
				Player.CurrentJumps = 1
		if (Player.Sprite.animation != "Fall" && Player.Sprite.animation != "Jump"):
			if Player.CurrentJumps != 2:
				Player.Sprite.play("Jump")
				Player.Sprite.frame = 4
			else: 
				Player.Sprite.play("Fall")
	if Player.is_on_floor():
		if is_zero_approx(Player.DirectionalInput.call().x):
			#Player.Sprite.play("Land")
			var msg = PlayerStateMessage.new(); msg.SkipAnimation = true
			state_machine.TransitionTo("Idle", msg)
		else:
			state_machine.TransitionTo("Run")
	
	if ((Player.EnableJumpBuffer and Player.JumpBuffer > 0.0 or Input.is_action_just_pressed("jump")) and Player.CoyoteTimer > 0.0 and not Player.Jumped and Player.EnableCoyote):
		var msg = PlayerStateMessage.new(); msg.DoJump = true
		state_machine.transition_to("Air", msg)
		return
	
	if Input.is_action_just_pressed("dash") and Player.CurrentDashes < Player.DashLimit:
		state_machine.TransitionTo("Dash")
		return
	
	if Input.is_action_just_pressed("jump"):
		var msg = PlayerStateMessage.new(); msg.DoJump = true
		state_machine.TransitionTo("Air", msg)
		return
	
	if Player.velocity.y < 0 and not Input.is_action_pressed("jump") and !_stoppedJump:
		if Player.EnableVariableJumpHeight:
			Player.velocity.y = Player.velocity.y * Player.VyMultiplier
		Player.CoyoteTimer = 0.0
		_stoppedJump = true
	
	if Player.CoyoteTimer > 0:
		Player.CoyoteTimer -= delta
	else:
		if Player.CurrentJumps == 0:
			Player.CurrentJumps = 1
	
	var finalGravity = Player.Gravity
	if _airState == AirState.Fall and Player.DirectionalInput.call().y > 0 and Player.EnableFastfall:
		finalGravity += Player.FastFallingGravity
	
	if Player.WallSum() != 0 and Player.WallSum() == sign(Player.DirectionalInput.call().x) and _airState == AirState.Fall and Player.EnableWallSlideAndWallJump:
		var msg = PlayerStateMessage.new(); msg.WallDirection = Player.WallSum.call()
		state_machine.TransitionTo("WallSlide", msg)
		return
	
	Player.velocity = Vector2((sign(Player.DirectionalInput.call().x) * Player.AerialMaxSpeed), Player.velocity.y + finalGravity * delta)
				
