extends CharacterBody2D
class_name PlayerController

# https://github.com/ChrisMGeo/GodotHollowKnightController/blob/main/Scripts/HollowKnightController/StateMachine/States/Air.cs

@onready var _leftWall: RayCast2D = $LeftWall
@onready var _rightWall: RayCast2D = $RightWall
@onready var Sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var CameraOffset: Marker2D = $CameraOffset
@onready var AttackArea: Area2D = $AttackArea

@export_subgroup("Attacking")
@export var AttackDamage = 1
@export var AttackTime =  0.4
@export var HitTime = 0.1
@export var drinkTime = 0.4
var DrinkTimer = 0
var HitTimer = 0
var AttackTimer = 0

@export_subgroup("Max Speed")
@export var GroundedMaxSpeed = 592.0/4;
@export var AerialMaxSpeed = 592.0/4;

@export_subgroup("Jump Physics")
@export var Jumps = 2
var CurrentJumps = 0
@export var _jumpHeight = 360/4
@export var _jumpPeakTime = .51
@export var _jumpDescentTime = .5
var JumpGravity: float
var JumpVelocity: float
var FallGravity: float
var Gravity: float

@export_subgroup("Variable Jump Height")
@export var EnableVariableJumpHeight = true;
@export var VyMultiplier = .125;

@export_subgroup("Jump Buffer")
@export var EnableJumpBuffer = true
@export var JumpBufferTime = .1
var JumpBuffer = 0.0

@export_subgroup("Coyote Time")
@export var EnableCoyote = true
@export var CoyoteTime = .1
var CoyoteTimer = 0.0

@export_subgroup("FastFalling")
@export var EnableFastfall = true
@export var FastFallingGravity = 1200/4

@export_subgroup("Sprite")
@export var ReverseSprite = false

@export_subgroup("Wall Slide and Wall Jump")
@export var EnableWallSlideAndWallJump = true;
@export var WallSlideVelocity =  585/4
@export var DetachFromWallOnNoInput = false
@export var WallJumpAngleInDegrees =  41.6
@export var WallJumpSpeed =  1300.0/4
@export var WallJumpTime =  0.1
var WallJumpTimer =  0.0

@export_subgroup("Dash")
@export var EnableDash =  true
@export var DashSpeed =  1200.0/4
@export var DashTime =  0.24
@export var DashLimit =  1
var DashTimer =  0.0
var CurrentDashes =  0

@export_subgroup("Camera Controls")
@export var HorizontalCameraBias =  32.0
@export var HorizontalAdjustTime =  0.125
var HorizontalCameraMovement: float

var FacingDirection = 1

func DirectionalInput(): return Input.get_vector("left", "right", "up", "down")
func Direction(): return DirectionalInput.call().normalized()
func Jumped(): return CurrentJumps > 0
func WallSum(): return (int(_rightWall.is_colliding()) - int(_leftWall.is_colliding()))

var invincible = false
@onready var invincibilityTimer = $Invincibility

func _ready() -> void:
	JumpGravity = (2.0 * _jumpHeight) / (_jumpPeakTime * _jumpPeakTime)
	JumpVelocity = 1.0 * JumpGravity * _jumpPeakTime
	FallGravity = (2.0 * _jumpHeight) / (_jumpDescentTime * _jumpDescentTime)
	Gravity = FallGravity
	HorizontalCameraMovement = HorizontalCameraBias / HorizontalAdjustTime
	
	Global.player = self
	
func _process(delta: float) -> void:
	if velocity.y >= 0: Gravity = FallGravity
	else: Gravity = JumpGravity
	
	if FacingDirection == -1: Sprite.flip_h = true
	else: Sprite.flip_h = false
	

func _physics_process(delta: float) -> void:
	Global.timer += delta
	
	move_and_slide()
	
	if Input.is_action_just_pressed("r"):
		Global.timer = 0.0
		Global.lastRespawn = null
		get_tree().reload_current_scene()
	
	if Input.is_action_just_pressed("jump"): JumpBuffer = JumpBufferTime
	elif JumpBuffer >= 0: JumpBuffer -= delta
	if WallJumpTimer >= 0: WallJumpTimer -= delta
	if DashTimer >= 0: DashTimer -= delta
	if AttackTimer >=0: AttackTimer -= delta;
	if HitTimer >=0: HitTimer -= delta;
	if DrinkTimer >=0: DrinkTimer -= delta;
	#CameraOffset.position.move_toward(Vector2((HorizontalCameraBias*FacingDirection), CameraOffset.Position.Y), (HorizontalCameraMovement*delta))
	
	if is_on_floor():
		CurrentJumps = 0
		CurrentDashes = 0
	if $LeftFloor.is_colliding() && $RightFloor.is_colliding():
		Global.lastSafeFloor = global_position
	
	if Input.is_action_just_pressed("attack") and $AttackArea.monitoring == false:
		Sprite.play("Attack")
		$AttackArea/SwordSound.play()
		$AttackArea/Sprite.play("default")
		var input = Input.get_axis("up", "down")
		# rotate attack area to where player is looking
		AttackArea.global_rotation = atan2(input, FacingDirection)
		#print(atan2(input.y, input.x))
		AttackTimer = AttackTime;
		AttackArea.monitoring = true;
		AttackArea.monitorable = true;
		AttackArea.get_child(0).disabled = false
	
	if AttackTimer <= 0:
		AttackArea.monitoring = false;
		AttackArea.monitorable = false;
		AttackArea.get_child(0).disabled = true
	
	if Input.is_action_just_pressed("debug"):
		$StateMachine.TransitionTo("Idle")


func _on_invincibility_timeout() -> void:
	invincible = false


func _on_boss_finished() -> void:
	pass # Replace with function body.


func _on_sound_finished() -> void:
	pass # Replace with function body.


func _on_attack_area_area_entered(area: Area2D) -> void:
	CurrentDashes = 0
	CurrentJumps = 0
