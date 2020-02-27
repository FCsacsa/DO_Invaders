extends Position2D

export (Vector2) var dir = Vector2(1, 0)
export (bool) var shoot
export (float) var cneed
export (int) var type = 0

var time

const proj0 = "res://proj/proj0.tscn"
const proj1 = "res://proj/proj1.tscn"
const proj2 = "res://proj/proj2.tscn"
const proj3 = "res://proj/proj3.tscn"

var player


var proj = [proj0, proj1, proj2, proj3]

var sfx

# Called when the node enters the scene tree for the first time.
func _ready():
	time = 0
	sfx = get_child(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if shoot and (time > cneed):
		sfx.play()
		dir = (global_position - get_parent().global_position).normalized()
		if type == 0:
			dir = Vector2(0,-1)
		else:
			dir = dir.normalized()
		time = 0
		var newProj = load(proj[type]).instance()
		if type == 3:
			newProj.init(dir.normalized(), global_position, player)
		else:
			newProj.init(dir.normalized(), global_position)
		get_parent().get_parent().add_child(newProj)
