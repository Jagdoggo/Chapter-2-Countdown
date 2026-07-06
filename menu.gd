extends Control

var last_days : int = -INF

func _process(delta: float) -> void:
	var string : String
	var target = {
		"year": 2026,
		"month": 7,
		"day": 25,
		"hour": 1,
		"minute": 0,
		"second": 0
	}
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
		string = "GO PLAY RIGHT NOW"
	else:
		string = "%d days, %02d hours, %02d minutes, and %02d seconds" % [days, hours, minutes, seconds]
	$VBoxContainer/Time.text = "Chapter 2 in: " + string
	if days != last_days:
		if days >= 0:
			var ammount = round(2500/pow(days+0.75,4.36))
			if ammount > 240:
				ammount = 240
			for child in $VBoxContainer/BoxContainer.get_children():
				child.queue_free()
			for i in range(ammount):
				$VBoxContainer/BoxContainer.add_child(load("res://extra_message.tscn").instantiate())
	last_days = days
