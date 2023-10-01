extends KinematicBody2D
var speed = 50
var velocity = Vector2()
var is_dead =false
export var direction = -1 #visible in the inspector 
export(int) var hitpoint = 3
export(int) var damage_count = 1
var life = 0

const JUMPFORCE =-1400
	
	

#func _exit_tree():
	#Global.David = null

func dead():
	is_dead = true
	velocity = Vector2(0,0)
	$AnimatedSprite.play("squashed")
	$CollisionShape2D.disabled = true
	$Timer.start()
	
func _ready():
	#Global.David = self
	#activate right side movement
	if direction == 1:
		$AnimatedSprite.flip_h = true
	#raycast
	$floor_detector.position.x = $CollisionShape2D.shape.get_extents().x * direction


	

func _physics_process(delta):
	# flip at collision on walls
	if is_dead == false: #enemy kepp moving if the enemy is not dead
		if is_on_wall() || ! $floor_detector.is_colliding() && is_on_floor():
			direction = direction * -1
			$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
			$floor_detector.position.x = $CollisionShape2D.shape.get_extents().x * direction
		
	velocity.y += 20
	velocity.x =speed * direction
	velocity = move_and_slide(velocity,Vector2.UP)
	


func _on_top_checker_body_entered(body):
	if body is KinematicBody2D:
		$AnimatedSprite.play("squashed")
		print("hurt")
		speed = 0
		set_collision_layer_bit(4,false)
		set_collision_mask_bit(0,false)
		$top_checker.set_collision_layer_bit(4,false)
		$top_checker.set_collision_mask_bit(0,false)
		$side_checker.set_collision_layer_bit(4,false)
		$side_checker.set_collision_mask_bit(0,false)
		$Timer.start()
		body.bounce()
		$SoundSquashed.play()
func bounce():
	velocity.y = JUMPFORCE * 0.7		

func _on_side_checker_body_entered(body):

	if body is KinematicBody2D:
		print("Yeeeeeeee")
		hitpoint -= damage_count
		if hitpoint <= 0:
			print("hit")
			get_tree().change_scene("res://scenes/level 1.tscn")
			
		else:
			_ready()
			

			
		

func _on_Timer_timeout():
	queue_free()
