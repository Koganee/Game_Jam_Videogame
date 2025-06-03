extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var footstep_player = $FootstepPlayer
@onready var footstep_timer = $FootstepTimer

const SPEED = 200.0
var is_attacking = false
@onready var sword_hitbox = $SwordHitbox


func _ready():
	add_to_group("player")

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_axis("ui_left", "ui_right")
	input_vector.y = Input.get_axis("ui_up", "ui_down")
	input_vector = input_vector.normalized()
	
	if not is_attacking:
		velocity = input_vector * SPEED

		# Handle animation and footstep logic
		if input_vector != Vector2.ZERO:
			animated_sprite_2d.play("walking")

			if input_vector.x < 0:
				animated_sprite_2d.flip_h = true
			elif input_vector.x > 0:
				animated_sprite_2d.flip_h = false

			if footstep_timer.is_stopped():
				footstep_timer.start()
		else:
			animated_sprite_2d.play("default")
			footstep_timer.stop()
	else:
		velocity = Vector2.ZERO

	move_and_slide()

	if Input.is_action_just_pressed("attack_slash") and not is_attacking:
		is_attacking = true
		animated_sprite_2d.play("attack_slash")
		footstep_timer.stop()

	if is_attacking:
		# Check all enemies already inside the hitbox
		if animated_sprite_2d.frame == 2 or animated_sprite_2d.frame == 3:
			for body in sword_hitbox.get_overlapping_bodies():
				if body is Enemy:
						body.die()

func _on_animated_sprite_2d_animation_finished():
	if animated_sprite_2d.animation == "attack_slash":
		is_attacking = false

func _on_footstep_timer_timeout():
	if velocity.length() > 0:
		footstep_player.play()


func _on_sword_hitbox_body_entered(body):
	if body is Enemy and animated_sprite_2d.animation == "attack_slash":
		body.die()

#func _on_player_hitbox_body_entered(body):
#	if body is Enemy:
#		body.take_damage(1, global_position)

