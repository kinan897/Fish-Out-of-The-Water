extends CharacterBody2D
class_name BigDrone

@export var health = 20
@export var speed = 5000

@onready var leftWall = $LeftWall
@onready var rightWall = $RightWall
@onready var leftFloor = $LeftFloor
@onready var rightFloor = $RightFloor
@onready var sprite = $AnimatedSprite2D

@export var FacingDirection = 1 # 1 is right, -1 is left

var enemy1 = preload("res://Enemys/Drone/drone.tscn")
var enemy2 = preload("res://Enemys/Robot/robot.tscn")

func _ready() -> void:
	randomize()

func _physics_process(delta: float) -> void:
	move_and_slide()


func _on_timer_timeout() -> void:
	var x
	
	if randi_range(0, 1) ==0:
		x = enemy1.instantiate()
	else:
		x = enemy2.instantiate()
	x.global_position = global_position
	get_parent().add_child(x)
	$Timer.start()


func _on_visible_on_screen_enabler_2d_screen_entered() -> void:
	Global.boss_music = true
	Global.play_sound()


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	Global.boss_music = false
