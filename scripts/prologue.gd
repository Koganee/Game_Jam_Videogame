extends Node2D
@onready var prologue_audio_player = $PrologueAudioPlayer
@onready var canvas_layer = $CanvasLayer
@onready var portal_player = $PortalPlayer
@onready var portal_player_2 = $PortalPlayer2

var portal_burst_count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_prologue_start_timer_timeout():
	prologue_audio_player.play()



func _on_prologue_audio_player_finished():
	canvas_layer.visible = true
	portal_player.play()


func _on_portal_player_finished():
	portal_player_2.play()


func _on_portal_player_2_finished():
	if portal_burst_count == 2:
		get_tree().change_scene_to_file("res://scenes/level_1.tscn")
	else:
		portal_player_2.play()
		portal_burst_count += 1
