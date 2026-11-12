extends CharacterBody2D
class_name BigBug 

@export var health = 15
@export var speed = 2000

@onready var leftWall = $LeftWall
@onready var rightWall = $RightWall
@onready var leftFloor = $LeftFloor
@onready var rightFloor = $RightFloor
@onready var sprite = $AnimatedSprite2D

@export var FacingDirection = 1 # 1 is right, -1 is left

func _physics_process(delta: float) -> void:
	move_and_slide()


func _on_visible_on_screen_enabler_2d_screen_entered() -> void:
	Global.boss_music = true
	Global.play_sound()


func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	Global.boss_music = false
