extends CharacterBody2D

const ROCKET_SCENE = preload("res://elements/rocket/rocket.tscn")

const MAX_SPEED = 140.0
const ACCELERATION = 0.03 # Factor de respuesta (0.0 a 1.0)

func _physics_process(delta: float):
	if Input.is_action_just_pressed("ui_accept"):
		shot()
		
	var direction = Input.get_axis("ui_left", "ui_right")
	
	# Si hay dirección, acelera progresivamente; si no, desacelera suavemente
	if direction != 0:
		velocity.x = lerp(velocity.x, direction * MAX_SPEED, ACCELERATION)
	else:
		velocity.x = lerp(velocity.x, 0.0, ACCELERATION)
		
	move_and_slide()

func shot():
	var rocket = ROCKET_SCENE.instantiate()
	rocket.global_position = global_position + Vector2(0, -30)
	add_child(rocket)

func take_damage():
	Globals.change_lives(-1)
