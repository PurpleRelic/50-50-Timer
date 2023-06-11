extends Node

var seconds: int = 0
var minutes: int = 10
var dtemp: float = 0
var moving: bool = false
var goingdown: bool = true
@onready var label = $UI/Label
@onready var alarm = $Alarm

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if moving:
		dtemp += delta
		if goingdown:
			if dtemp >= 1:
				if seconds == 0 and minutes == 0:
					dtemp -= 1
					alarm.play()
				else:
					dtemp -= 1
					seconds -= 1
					if seconds < 0:
						minutes -= 1
						seconds += 60
		else:
			if dtemp >= 1:
				dtemp -= 1
				seconds += 1
				if seconds >= 60:
					minutes += 1
					seconds -= 60
	if seconds <= 9:
		label.text = str(minutes, ":0", seconds)
	else:
		label.text = str(minutes, ":", seconds)

func _unhandled_key_input(event):
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE and event.pressed:
			get_tree().quit()
		if event.keycode == KEY_SPACE and event.pressed:
			moving = true
			if minutes == 0 and seconds == 0:
				goingdown = false
				alarm.stop()
			else:
				goingdown = true
				alarm.stop()
		if event.keycode == KEY_P and event.pressed:
			moving = false
		if event.keycode == KEY_UP and event.pressed:
			minutes += 1
		if event.keycode == KEY_DOWN and event.pressed:
			minutes -= 1
		if event.keycode == KEY_W and event.pressed:
			seconds += 10
			if seconds >= 60:
				minutes += 1
				seconds -= 60
		if event.keycode == KEY_S and event.pressed:
			seconds -= 10
			if seconds < 0:
				minutes -= 1
				seconds += 60
