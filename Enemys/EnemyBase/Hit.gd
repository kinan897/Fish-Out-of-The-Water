extends State

var timer = 0
var enemy: EnemyBase

func Enter(msg: StateMessage) -> void:
	if (state_machine and !enemy):
		enemy = state_machine.get_parent()
	if enemy.health <= 0:
		state_machine.TransitionTo("Die")
		return
	
	enemy.velocity = Vector2.ZERO
	enemy.sprite.play("stun")

	timer = 0.5
	
	var dif = (Global.player.global_position - enemy.global_position).normalized()
	Global.hit(0, dif)

func PhysicsUpdate(delta: float) -> void:
	timer -= delta
	if timer <= 0:
		state_machine.TransitionTo("Walk")
	
