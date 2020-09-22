extends KinematicBody2D

var velocity = Vector2(0, 0)
var isFacingRight = true

const UP = Vector2(0, -1)
const SPEED = 300
const JUMP_SPEED = 1300
const GRAVITY = 150

func _physics_process(delta):
	fall()
	jump()
	move()
	animate()
	
	move_and_slide(velocity, UP)
	
func fall():
	if is_on_floor():
		velocity.y = 0
	else:
		velocity.y += GRAVITY

func jump():
	if is_on_floor() and Input.is_action_just_pressed("Jump"):
		velocity.y -= JUMP_SPEED

func move():
	if Input.is_action_pressed("Left") and not Input.is_action_pressed("Right"):
		velocity.x = -SPEED
		isFacingRight = false
	elif Input.is_action_pressed("Right") and not Input.is_action_pressed("Left"):
		velocity.x = SPEED
		isFacingRight = true
	else:
		velocity.x = 0
		

		
func animate():
	if isFacingRight:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false
		
	if velocity.y < 0 :
		$AnimatedSprite.play("jumping")
	elif velocity.x != 0 :
		$AnimatedSprite.play("walking")
	else:
		$AnimatedSprite.play("idle")
