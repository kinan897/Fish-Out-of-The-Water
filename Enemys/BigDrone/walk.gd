extends State

var enemy:BigDrone

func Enter(msg: StateMessage) -> void:
	if (state_machine and !enemy):
		enemy = state_machine.get_parent()
	enemy.sprite.play("default")

func PhysicsUpdate(delta: float) -> void:
	
	var dif = (Global.player.global_position - enemy.global_position).normalized()
	
	enemy.velocity = dif*enemy.speed*delta
	
	if enemy.velocity.x >0:
		enemy.FacingDirection = 1
	elif enemy.velocity.x < 0:
		enemy.FacingDirection = - 1
	
	
	enemy.sprite.flip_h = enemy.FacingDirection == -1
	
	


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Hitbox"):
		enemy.health -= 1
		state_machine.TransitionTo("Hit")
	if area.is_in_group("Hurtbox"):
		var dif = (area.global_position - enemy.global_position).normalized()
		
		Global.hit(1, dif)
		
