extends CanvasLayer

@onready var desert = $Desert
@onready var cave = $Cave
@onready var factory = $Factory



# Cave
func _on_area_2d_body_entered(body: Node2D) -> void:
	cave.visible = true
	desert.visible = false
	factory.visible = false


func _on_desert_body_entered(body: Node2D) -> void:
	desert.visible = true
	cave.visible = false
	factory.visible = false


func _on_cave_body_entered(body: Node2D) -> void:
	cave.visible = true
	desert.visible = false
	factory.visible = false


func _on_factory_body_entered(body: Node2D) -> void:
	cave.visible = false
	desert.visible = false
	factory.visible = true


func _on_sound_finished() -> void:
	$Sound.play()
