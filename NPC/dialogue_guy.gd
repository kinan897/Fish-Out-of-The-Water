extends Area2D
class_name  DialogueGuy

var player_inside = false
@export var dialogue: Array[String] = ["text"]
var index = -1

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("up") and player_inside:
		index = (index + 1) % dialogue.size()
	if index != -1:
		$DialogueTrigger.text = dialogue[index]
	else:
		$DialogueTrigger.text = "up"

func _on_body_entered(body: Node2D) -> void:
	$DialogueTrigger.visible = true
	player_inside = true
	index = -1

func _on_body_exited(body: Node2D) -> void:
	$DialogueTrigger.visible = false
	player_inside = false
	index = -1


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("hitbox"):
		var dif = (Global.player.global_position - global_position).normalized()
		Global.hit(0, dif)
