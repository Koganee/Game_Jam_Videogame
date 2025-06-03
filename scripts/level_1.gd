extends Node2D

@onready var lab_alarm_player = $LabAlarmPlayer
@onready var lab_emergency_light = $LabEmergencyLight
@onready var alarm_timer = $AlarmTimer

var light_on := true

func _ready():
	lab_alarm_player.play()
	alarm_timer.start()

func _process(delta):
	pass

func _on_lab_alarm_player_finished():
	lab_alarm_player.play()

func _on_timer_timeout():
	# Toggle the light's energy between 0 and 1
	light_on = !light_on
	lab_emergency_light.energy = 0.3 if light_on else 0
