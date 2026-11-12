extends PlayerState

var kb = Vector2.ZERO

func Enter(msg: StateMessage) -> void:
	Player.HitTimer = Player.HitTime
	Player.velocity = Vector2.ZERO
	if Global.health <= 0:
		$DeathSound.play()
		Player.Sprite.play("Death")
		state_machine.TransitionTo("Death", PlayerStateMessage.new())
		return
		#Player.global_position = Global.lastRespawn.global_position
	$HurtSound.play()
	if (msg is PlayerStateMessage):
		kb = msg.kb * 500/4

func PhysicsUpdate(delta: float) -> void:
	Player.velocity = kb
	kb -= kb.normalized() * delta * 500 * Player.AttackTime/4
	kb.y -= 1*delta
	if Player.HitTimer <= 0:
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
	Player.move_and_slide()
