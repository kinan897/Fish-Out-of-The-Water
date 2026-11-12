extends CanvasLayer

@onready var health_label = $GameUI/health
@onready var thirst_label = $GameUI/thirst

const heartScene = preload("res://Singletons/Heart.tscn")

var max_health = 5
var max_thirst = 9

var boss_music = false

var timer = 0.0

var hearts: Array = []
var health = 5:
	set(value):
		health = clamp(value, 0, max_health)
		print(health)
		_update_hearts()
		if value <= 0:
			player.global_position = lastRespawn.global_position
		
var thirst = 9

var player: PlayerController

var lastRespawn: Fountain
var lastSafeFloor: Vector2

func _ready() -> void:
	_rebuild_hearts()

func _process(delta: float) -> void:
	
	var x = timer*100
	x = roundf(x)/100
	var time_string := "%02d:%02d.%02d" % [
	int(timer / 60),
	int(timer) % 60,
	int((timer - int(timer)) * 100)
]
	$Timer.text = time_string
	if boss_music:
		$Sound.stop()
	else: $Boss.stop()
	if health > max_health: health = max_health
	#health_label.text = "health: " + str(health)
	#thirst_label.text = "thirst: " + str(thirst)

	$GameUI/ThirstBar.value = thirst
	for heart in $GameUI/HealthContainer.get_children():
		pass

func _rebuild_hearts():
	for child in $GameUI/HealthContainer.get_children():
		child.queue_free()
	hearts.clear()
	
	for i in max_health:
		var heart = heartScene.instantiate()
		$GameUI/HealthContainer.add_child(heart)
		hearts.append(heart)
		

func _update_hearts():
	for i in hearts.size():
		hearts[i].set_on(i < health)

func hit(damage: int, knockback:Vector2) -> void:
	if not player.invincible:
		health -= damage
		var msg = PlayerStateMessage.new(); msg.kb = knockback
		player.get_node("StateMachine").TransitionTo("Hurt", msg)
		player.invincible = true
		player.invincibilityTimer.start()


func _on_sound_finished() -> void:
	if not boss_music:
		$Sound.play()

func _on_boss_finished() -> void:
	if boss_music:
		$Boss.play()
	
func play_sound():
	if boss_music:
		$Boss.play()
		$Sound.stop()
	else: 
		$Sound.play()
		$Boss.stop()
		
