extends State

var enemy:Robot

func Enter(msg: StateMessage) -> void:
	if (state_machine and !enemy):
		enemy = state_machine.get_parent()
	enemy.sprite.play("walk")

func PhysicsUpdate(delta: float) -> void:
	if (enemy.leftWall.is_colliding()):
		enemy.FacingDirection = 1
	if (not enemy.leftFloor.is_colliding()):
		enemy.FacingDirection = 1
	if (enemy.rightWall.is_colliding()):
		enemy.FacingDirection = -1
	if (not enemy.rightFloor.is_colliding()):
		enemy.FacingDirection = -1
	
	if (!enemy.is_on_floor()):
		enemy.velocity.y += 98*delta
	enemy.velocity.x = enemy.FacingDirection*enemy.speed*delta
	
	enemy.sprite.flip_h = enemy.FacingDirection == -1
	
	


func _on_hitbox_area_entered(area: Area2D) -> void:
	if area.is_in_group("Hitbox"):
		enemy.health -= 1
		state_machine.TransitionTo("Hit")
	if area.is_in_group("Hurtbox"):
		var dif = (area.global_position - enemy.global_position).normalized()
		
		Global.hit(1, dif)
		
