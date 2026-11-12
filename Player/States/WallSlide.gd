extends PlayerState

var _wallDirection: int

func Enter(msg: StateMessage):
	Player.CurrentJumps = 1
	Player.CurrentDashes = 0
	Player.WallJumpTimer = 0.0
	
	if msg is PlayerStateMessage:
		if msg.WallDirection != 0:
			_wallDirection = msg.WallDirection
	
	Player.Sprite.play("WallSlide")
	Player.velocity = Vector2(0, Player.WallSlideVelocity)

func PhysicsUpdate(dalta: float):
	if Player.is_on_floor():
		Player.Sprite.play("Land")
		var msg = PlayerStateMessage.new(); msg.SkipAnimation = true
		state_machine.TransitionTo("Idle", msg)
		return
	
	if Player.WallSum() == 0 or (Player.DetachFromWallOnNoInput and Player.DirectionalInput().x == 0) or sign(Player.DirectionalInput().x) == -_wallDirection:
		state_machine.TransitionTo("Air")
		return
	
	if Player.EnableJumpBuffer and Player.JumpBuffer > 0.0 or not Player.EnableJumpBuffer and Input.is_action_just_pressed("jump"):
		state_machine.TransitionTo("WallJump")
		return
	
	if Input.is_action_just_pressed("dash") and Player.CurrentDashes < Player.DashLimit:
		state_machine.TransitionTo("Dash")
		return

func Exit():
	Player.FacingDirection = -_wallDirection
