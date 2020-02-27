extends Node2D

export (float) var cNeed = 0

var time = 0
var spawn_patterns = {
	"easy" : [
		[
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[ 0, 200],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			],
		[
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[ 1, 200],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			],
		[
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[ 2, 200],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			],
		[
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[ 3, 200],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			],
		[
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[ 4, 200],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			],
		[
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[ 0, 200],
			[ 0, 200],
			[ 0, 200],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			],
		[
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[ 0, 000],
			[ 0, 000],
			[ 0, 200],
			[ 0, 000],
			[ 0, 000],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			],
		[
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[ 5, 200],
			[ 5, 200],
			[ 5, 200],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			],
		[
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[ 5, 200],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			],
		[
			[ 2, 400],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[ 2, 200],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[-1, 000],
			[ 2, 400],
			]
	],
	"medium" : [],
	"hard" : []
}

const e1 = "res://enemies/enemy1.tscn"
const e2 = "res://enemies/enemy2.tscn"
const e3 = "res://enemies/enemy3.tscn"
const e4 = "res://enemies/enemy4.tscn"

var types = [
	[e1, 0, 50],
	[e1, 1, 75],
	[e2, 3, 100],
	[e3, 2, 150],
	[e4, 1, 200],
	[e4, 0, 150]
]

var enemies
var was = false

func _ready():
	enemies = get_child(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	if enemies.get_child_count() == 0 and was:
		time = 0
		was = false
		if rand_range(0, 10) > 6:
			get_parent().get_child(0).get_child(0).life += 1
	if enemies.get_child_count() == 0 and time > cNeed:
		var spawnPat = _getRandomSpawnPat()
		_spawn_Pat(spawnPat)
	if enemies.get_child_count() > 0:
		was = true

func _getRandomSpawnPat():
	var n = spawn_patterns["easy"].size()
	return spawn_patterns["easy"][randi()%n]
	

func _spawn_Pat(pat):
	var i = 1
	for e in pat:
		if e[0] != -1:
			var new = load(types[e[0]][0]).instance()
			var newE = new.get_child(0)
			newE.goal = float(e[1])
			newE.type = types[e[0]][1]
			newE.points = types[e[0]][2]
			newE.set_player(get_parent().get_child(0).get_child(0))
			enemies.add_child(new)
			newE.global_position = get_child(i).global_position
			
		i += 1
