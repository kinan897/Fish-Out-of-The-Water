extends AnimatedSprite2D

func _on_animation_finished() -> void:
	match animation:
		"IdleToRun":
			play("Run")
		"Turn":
			play("IdleToRun")
		"RunToIdle", "Land", "DashToIdle":
			play("Idle")
		"Jump", "DoubleJump", "Dash":
			play("Fall")
		"Attack":
			play("Idle")
			
