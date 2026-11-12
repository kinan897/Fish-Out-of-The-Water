extends State
class_name PlayerState

var Player: PlayerController

func _ready() -> void:
	await owner.ready
	Player = owner
