extends CharacterBody2D
class_name Fish

@export var health = 2
@export var speed = 1000

@onready var leftWall = $LeftWall
@onready var rightWall = $RightWall
@onready var leftFloor = $LeftFloor
@onready var rightFloor = $RightFloor
@onready var sprite = $AnimatedSprite2D

@export var FacingDirection = 1 # 1 is right, -1 is left

func _physics_process(delta: float) -> void:
	move_and_slide()
