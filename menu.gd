extends Control

@onready var sooner: CheckButton = $VBoxContainer/Sooner
@onready var until_trailer_2: CheckButton = $"VBoxContainer/Until Trailer #2"

var last_days : int = -INF
var extra = load("res://extra_message.tscn")

func _process(delta: float) -> void:
	var string : String
	var target = {
		"year": 2026,
		"month": 7,
		"day": 24,
		"hour": 17,
		"minute": 0,
		"second": 0
	}
	if until_trailer_2.button_pressed:
		target["day"] = 17
	if sooner.button_pressed:
		target["day"] -= 2
	var target_unix = Time.get_unix_time_from_datetime_dict(target)
	var current_unix = Time.get_unix_time_from_system()
	var difference = target_unix - current_unix
	var seconds
	var minutes
	var hours
	var days
	seconds = int(difference) % 60
	minutes = int(difference / 60) % 60
	hours = int(difference / 3600) % 24
	days = int(difference / 86400)
	if difference <= 0:
		if until_trailer_2.button_pressed:
			string = "GO WATCH RIGHT NOW"
		else:
			string = "GO PLAY RIGHT NOW"
	else:
		string = "%d days, %02d hours, %02d minutes, and %02d seconds" % [days, hours, minutes, seconds]
	$VBoxContainer/Time.text = "Chapter 2 in: " + string
	if days != last_days:
		if days >= 0:
			var ammount = round(2500/pow(days+0.75,4.36))
			if ammount > 216:
				ammount = 216
			for child in $VBoxContainer/BoxContainer.get_children():
				child.queue_free()
			for i in range(ammount):
				var node = extra.instantiate()
				if until_trailer_2.button_pressed:
					node.text = "Trailer 2"
				$VBoxContainer/BoxContainer.add_child(node)
	last_days = days
