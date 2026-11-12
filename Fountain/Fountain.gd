extends Area2D
class_name Fountain

func _on_body_entered(body: Node2D) -> void:
	Global.health = Global.max_health
	Global.thirst = Global.max_thirst
	Global.lastRespawn = self
