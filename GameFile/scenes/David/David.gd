extends KinematicBody2D
var velocity = Vector2(0,0)
const SPEED =500
const GRAVITY = 75
const JUMPFORCE =-1400

const FIREBALL = preload("res://fireballs/Fireball.tscn")
export (int) var health = 3
var coins = 0

func bounce():
	velocity.x = 5 * 2 
	


	
	
func _physics_process(_delta):	
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED	
		$Sprite.play("run")
		$Sprite.flip_h = false
		#to assign fireball position to input
		if sign ($Position2D.position.x) == -1:
			$Position2D.position.x *= -1
		
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$Sprite.play("run")
		$Sprite.flip_h = true
		if sign ($Position2D.position.x) == 1:
			$Position2D.position.x *= -1
	else :
		$Sprite.play("idle")
		velocity.x = lerp(velocity.x,0,0.2)
	if not is_on_floor():
		$Sprite.play("jump")	
		

	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMPFORCE
		$SoundJump.play()
		$Sprite.play ("idle")
	velocity.y = velocity.y+ GRAVITY	
	move_and_slide(velocity, Vector2.UP)
	velocity.x = lerp(velocity.x,0,0.2)
	
	
	
	if Input.is_action_just_pressed("ui_focus_next"):
		var fireball = FIREBALL.instance()
		if sign($Position2D.position.x) ==1:
			fireball.set_fireball_direction(1)
		else:
			fireball.set_fireball_direction(-1)
		get_parent().add_child(fireball)
		fireball.position = $Position2D.global_position
	if $Sprite is KinematicBody:
		bounce()

	

