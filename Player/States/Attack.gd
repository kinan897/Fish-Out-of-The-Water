extends PlayerState

func Enter(msg: StateMessage):
	var input = Input.get_vector("left", "right", "up", "down")
	
	# rotate attack area to where player is looking
	Player.AttackArea.global_rotation = atan2(input.y, Player.FacingDirection)
	print(atan2(input.y, input.x))
	Player.AttackTimer = Player.AttackTime;
	
	Player.AttackArea.monitoring = true;
	Player.AttackArea.monitorable = true;
	Player.AttackArea.get_child(0).disabled = false
	
	Player.Sprite.play("Attack")
	if (msg is PlayerStateMessage):
		if msg.SkipAnimation == false:
			return
	
			
func PhysicsUpdate(delta: float) -> void:
	
	if Player.AttackTimer <= 0:
		Player.AttackArea.monitoring = false;
		Player.AttackArea.monitorable = false;
		Player.AttackArea.get_child(0).disabled = true
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
		
# u still want to move
	Player.velocity = Vector2(Player.GroundedMaxSpeed * sign(Player.DirectionalInput.call().x), Player.velocity.y)
