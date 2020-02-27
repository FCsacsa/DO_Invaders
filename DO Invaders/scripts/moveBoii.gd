extends KinematicBody2D

export (float) var speedXm = 600
export (float) var speedYm = 400
export (float) var speedX = 600
export (float) var speedY = 400
export (float) var accX = 5000
export (float) var accY = 5000
export (float) var rot = 30 * 5000 / 600
export (float) var rotM = 30

var size = Vector2(20, 24)
var screen = Vector2()


var life = 10
var healthBar
var score = 0
var auto = false

# Called when the node enters the scene tree for the first time.
func _ready():
	screen = get_viewport_rect().size
	healthBar = get_parent().get_child(1)
	var options = File.new()
	if options.file_exists("res://saves/options.json"):
		options.open("res://saves/options.json", File.READ)
		var line = parse_json(options.get_line())
		auto = line["auto"]
		print_debug(auto)
		options.close()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_move(delta)
	_shoot()
	
	_quit()
	
	_print_life()
	_show_point()



func inScreen(v):
	var x = v.x
	var xmin = size.x / 2
	var xmax = screen.x - xmin
	if xmin < x and x < xmax:
		var y = v.y
		var ymin = size.y / 2
		var ymax = screen.y - ymin
		if ymin < y and y < ymax:
			return true
	return false

func _move(delta):
	var move = Vector2(0, 0)
	
	if Input.is_action_pressed("left"):
		if speedX > -speedXm:
			speedX -= accX * delta
		elif speedX < -speedXm:
			speedX = -speedXm
		if rotation_degrees > -rotM:
			rotation_degrees -= rot * delta
		elif rotation_degrees < -rotM:
			rotation_degrees = -rotM
	elif Input.is_action_pressed("right"):
		if speedX < speedXm:
			speedX += accX * delta
		elif speedX > speedXm:
			speedX = speedXm
		if rotation_degrees < rotM:
			rotation_degrees += rot * delta
		elif rotation_degrees > rotM:
			rotation_degrees = rotM
	else:
		if speedX > 10:
			speedX -= accX * delta
		elif speedX < -10:
			speedX += accX * delta
		else:
			speedX = 0
		
		if rotation_degrees > 10:
			rotation_degrees -= delta * rot
		elif rotation_degrees < -10:
			rotation_degrees += delta * rot
		else:
			rotation_degrees = 0
	
	if Input.is_action_pressed("up"):
		if speedY > -speedYm:
			speedY -= accY * delta
		elif speedY < -speedYm:
			speedY = -speedYm
	elif Input.is_action_pressed("down"):
		if speedY < speedYm:
			speedY += accY * delta
		elif speedY > speedYm:
			speedY = speedYm
	else:
		if speedY > 10:
			speedY -= accY * delta
		elif speedY < -10:
			speedY += accY * delta
		else:
			speedY = 0
	
	
	move = delta * Vector2(speedX, speedY)
	var collision = null
	if inScreen(position + move):
		collision = move_and_collide(move)
	
	if collision:
		if collision.collider.has_method("destroy"):
			life -= 1
			collision.collider.destroy()
		

func _shoot():
	if Input.is_action_pressed("shoot") or auto:
		get_child(0).shoot = true
	else:
		get_child(0).shoot = false

func _quit():
	if(Input.is_action_pressed("quit")):
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/main_menu.tscn")

func _print_life():
	healthBar.value = life
	if life == 0:
		var save = File.new()
		var highscore = 0
		if save.file_exists("res://saves/scores.json"):
			save.open("res://saves/scores.json", File.READ)
			highscore = parse_json(save.get_line())["highscore"]
			save.close()
		save.open("res://saves/scores.json", File.WRITE)
		var new = highscore < score
		highscore = max(highscore, score)
		save.store_line(str({
			"\"highscore\"" : highscore,
			"\"score\"" : score,
			"\"new\"" : new
		}).to_lower())
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/game over.tscn")


func _show_point():
	get_parent().get_child(2).text = str(score)
