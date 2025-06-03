extends Node2D

@onready var wizard_dialogue_player = $WizardDialoguePlayer
@onready var sword_sprite = $SwordSprite
@onready var dialogue_trigger = $DialogueTrigger
@onready var explosion_animation = $ExplosionAnimation

var player_body = null  # Store the body for later use

func _ready():
	pass

func _process(delta):
	pass

func _on_dialogue_trigger_body_entered(body):
	player_body = body
	wizard_dialogue_player.play()
	player_body.is_attacking = true

func _on_wizard_dialogue_player_finished():
	dialogue_trigger.queue_free()
	if player_body:
		player_body.is_attacking = false
		sword_sprite.visible = true


func _on_sword_pickup_trigger_body_entered(body):
	explosion_animation.visible = true
	explosion_animation.play("default")


func _on_explosion_animation_timer_timeout():
	get_tree().change_scene_to_file("res://scenes/arena_2.tscn")
