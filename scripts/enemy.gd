extends CharacterBody2D
class_name Enemy

@onready var animated_sprite_2d = $AnimatedSprite2D

@export var speed = 30.0
@export var health = 10
@export var knockback_duration = 0.2  # Seconds

var target : Node2D
var knockback_velocity = Vector2.ZERO
var knockback_timer = 0.0

func _ready():
	target = get_tree().get_first_node_in_group("player")

func _physics_process(delta):
	if knockback_timer > 0:
		velocity = knockback_velocity
		knockback_timer -= delta
	else:
		if target:
			var direction = (target.global_position - global_position).normalized()
			velocity = direction * speed

	move_and_slide()

func take_damage(amount: int, from_position: Vector2 = Vector2.ZERO):
	health -= amount

	if from_position != null:
		# Apply knockback away from the damage source
		var knockback_dir = (global_position - from_position).normalized()
		knockback_velocity = knockback_dir * 300  # Knockback force
		knockback_timer = knockback_duration

	if health <= 0:
		die()

func die():
	animated_sprite_2d.play("killed")


func _on_animated_sprite_2d_animation_finished():
	if animated_sprite_2d.animation == "killed":
		queue_free()
