extends KinematicBody2D


export (Vector2) var dir = Vector2(1, 0).normalized()
export (float) var speed = 200
export (float) var size = 8

var screen
var player
var timer

# Called when the node enters the scene tree for the first time.
func _ready():
	screen = get_viewport_rect().size
	dir = dir.normalized()
	timer = get_child(2)
	timer.connect("timeout", self, "destroy")

func init(v, pos, playerNode=null):
	dir = v.normalized()
	global_position = pos
	player = playerNode


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if player:
		dir = (player.global_position - global_position).normalized()
	var _collison = move_and_collide(speed * delta * dir)
	rotation = dir.angle() + PI/2
	if position.x > screen.x + size / 2 or position.y > screen.y + size / 2:
		queue_free()
	if position.x < - size / 2 or position.y < - size / 2:
		queue_free()

func destroy():
	queue_free()
