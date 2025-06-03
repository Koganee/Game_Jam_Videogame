extends Node2D

@onready var music_player = $MusicPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_sword_hitbox_body_entered(body):
	if body is Enemy:
		if Input.is_action_just_pressed("attack_slash"):
			body.queue_free()


func _on_music_player_finished():
	music_player.play()
