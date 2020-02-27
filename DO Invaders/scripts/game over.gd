extends Control

var score
var highscore
var new
var scores


# Called when the node enters the scene tree for the first time.
func _ready():
	scores = File.new()
	if scores.file_exists("res://saves/scores.json"):
		scores.open("res://saves/scores.json", File.READ_WRITE)
		var line = parse_json(scores.get_line())
		new = line["new"]
		score = line["score"]
		highscore = line["highscore"]
		
		scores.store_line(str({
			"\"highscore\"" : highscore,
			"\"score\"" : 0,
			"\"new\"" : false
		}).to_lower())
		scores.close()
	else:
		new = false
		score = 0
		highscore = 0
	
	
	if not new:
		get_child(2).hide()
	get_child(0).text = str(score)
	get_child(1).text = str(highscore)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("shoot"):
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/level.tscn")
	if Input.is_action_just_pressed("quit"):
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/main_menu.tscn")
