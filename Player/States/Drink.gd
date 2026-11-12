extends PlayerState

var drinks = 0

func Enter(msg: StateMessage) -> void:
	drinks = 0
	Player.DrinkTimer = Player.drinkTime

func PhysicsUpdate(delta: float) -> void:
	if Input.is_action_pressed("drink") and Global.thirst > 0:
		if Player.DrinkTimer <= 0:
			$DrinkSound.play()
			drinks+= 1
			Global.thirst -= 1
			Player.DrinkTimer = Player.drinkTime
			
			
			if drinks >= 3:
				Global.health += 1
				drinks = 0
	else:
		state_machine.TransitionTo("Idle")
