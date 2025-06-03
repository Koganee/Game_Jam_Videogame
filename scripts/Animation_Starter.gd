extends Area2D
@onready var explosion_animation = $"../ExplosionAnimation"
@onready var explosion_animation_player = $"../ExplosionAnimationPlayer"
@onready var canvas_layer = $"../CanvasLayer"
@onready var explosion_animation_timer = $"../ExplosionAnimationTimer"


func _on_body_entered(body):
	animation_start()

func animation_start():
	explosion_animation_timer.start()
	explosion_animation.visible = true
	explosion_animation.play("default")
	explosion_animation_player.play()


func _on_explosion_animation_timer_timeout():
	canvas_layer.visible = true
	get_tree().change_scene_to_file("res://scenes/arena.tscn")
