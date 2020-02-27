extends KinematicBody2D

export (int) var type = 0
export (float) var goal = 100
export (float) var speed = 200 
export (int) var points = 50 
export (Vector2) var size = Vector2(60, 60)

export (int) var life = 10

var move = Vector2(0,0)
var xMod = 1
var player

# Called when the node enters the scene tree for the first time.
func _ready():
	get_child(1).player = player


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_moveY(delta)
	_moveX(delta)
	if type == 2:
		_rot_to_player()
	var collide = move_and_collide(move)
	if collide:
		if move.y == 0:
			life -= 1
		collide.collider.destroy()
	
	_shoot()
	_show_life()
	_die()

func _moveY(delta):
	if global_position.y < goal:
		move.y = speed * delta
	else:
		move.y = 0
	
func _moveX(delta):
	if type == 0 or not global_position.y > size.y / 2 or type == 3:
		move.x = 0
	elif type == 1 or type == 2:
		if global_position.x < size.x / 2:
			xMod = 1
		if global_position.x > get_viewport_rect().size.x - size.x / 2:
			xMod = -1
		move.x = xMod * speed * delta
		
func _rot_to_player():
	rotation = (player.global_position - global_position).angle() - PI/2

func _shoot():
	if move.y == 0:
		get_child(1).shoot = true
		if type == 3:
			get_child(2).shoot = true
			get_child(3).shoot = true
			get_child(4).shoot = true
			get_child(5).shoot = true
			get_child(6).shoot = true
			get_child(7).shoot = true
			get_child(8).shoot = true
	else:
		get_child(1).shoot = false
		if type == 3:
			get_child(2).shoot = false
			get_child(3).shoot = false
			get_child(4).shoot = false
			get_child(5).shoot = false
			get_child(6).shoot = false
			get_child(7).shoot = false
			get_child(8).shoot = false

func _show_life():
	get_child(0).value = life
	if type == 3:
		get_child(9).text = str(life)
	else:
		get_child(2).text = str(life)



func _die():
	if life <= 0:
		player.score += points
		get_parent().queue_free()
		


func set_player(playerNode):
	player = playerNode
