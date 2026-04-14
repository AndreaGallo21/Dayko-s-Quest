extends CharacterBody2D

const SPEED = 180.0
const JUMP_VELOCITY = -300.0

func _physics_process(delta: float) -> void:
	# 1. Gravedad
	if not is_on_floor():
		velocity += get_gravity() * delta

	# 2. Salto
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# 3. Movimiento y Dirección
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
		$Sprite2D.flip_h = (direction < 0)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# 4. MÁQUINA DE ESTADOS (Las animaciones)
	if not is_on_floor():
		$AnimationPlayer.play("idle")
		$AnimationPlayer.stop()
	elif direction != 0:
		$AnimationPlayer.play("run")
	else:
		$AnimationPlayer.play("idle")

	move_and_slide()


func _on_zona_muerte_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
