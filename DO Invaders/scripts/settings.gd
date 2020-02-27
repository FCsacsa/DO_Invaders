extends Control


var auto = false
var reset = false
var highscore = 0
var scores
var options

# Called when the node enters the scene tree for the first time.
func _ready():
	scores = File.new()
	options = File.new()
	if not scores.file_exists("res://saves/scores.json"):
		scores.open("res://saves/scores.json", File.WRITE)
		reset = true
	else:
		scores.open("res://saves/scores.json", File.READ)
		var line = parse_json(scores.get_line())
		highscore = line["highscore"]
		scores.open("res://saves/scores.json", File.WRITE)
		if highscore == 0:
			reset = true
	
	if not options.file_exists("res://saves/options.json"):
		options.open("res://saves/options.json", File.WRITE)
		reset = true
	else:
		options.open("res://saves/options.json", File.READ)
		var line = parse_json(options.get_line())
		auto = line["auto"]
		options.open("res://saves/options.json", File.WRITE)
	_print_auto()
	_print_res()

# Called every frame. \"delta\" is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_pressed("quit"):
		if scores:
			scores.store_line(str({
				"\"highscore\"" : highscore,
				"\"score\"": 0,
				"\"new\"": false	
				}).to_lower())
			scores.close()
		if options:
			options.store_line(str({"\"auto\"" : auto}).to_lower())
			options.close()
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/main_menu.tscn")
	if Input.is_action_pressed("r") and Input.is_action_pressed("e") and Input.is_action_pressed("s"):
		if not reset:
			reset = true
			highscore = 0
			_print_res()
	if Input.is_action_just_pressed("shoot"):
		auto = not auto
		_print_auto()
		
func _print_auto():
	if auto:
		get_child(0).text = "ON"
		get_child(0).add_color_override("font_color", Color(0,1,0))
	else:
		get_child(0).text = "OFF"
		get_child(0).add_color_override("font_color", Color(1,0,0))

func _print_res():
	if reset:
		get_child(1).text = "No Save"
		get_child(1).add_color_override("font_color", Color(1,0.3,0.3))
	else:
		get_child(1).text = "Saved"
		get_child(1).add_color_override("font_color", Color(0.3,1,0.3))
