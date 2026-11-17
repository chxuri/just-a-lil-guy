extends CharacterBody2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var dead = false
var win = false

const SPEED = 300.0
const JUMP_VELOCITY = -700.0


func _physics_process(delta: float) -> void:
	# Add animation 
	if velocity.x > 1 or velocity.x < -1:
		animated_sprite_2d.animation = "walking"
	else:
		animated_sprite_2d.animation = "idle"
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite_2d.animation = "jumping"

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	if direction == 1.0:
		animated_sprite_2d.flip_h = false
	elif direction == -1:
		animated_sprite_2d.flip_h = true

func _process(delta):
	
	if dead or win:
		return
	if animated_sprite_2d.global_position.y > 2500:
		dead = true 
		
		for platform in get_tree().get_nodes_in_group("moving_platforms"):
			platform.stop_tween()
		
		get_tree().change_scene_to_file("res://scenes/die_screen.tscn")
		
		return
	
	if animated_sprite_2d.global_position.x > 4250:
		win = true
		
		for platform in get_tree().get_nodes_in_group("moving_platforms"):
			platform.stop_tween()
			
		get_tree().change_scene_to_file("res://scenes/win_screen.tscn")
		return
