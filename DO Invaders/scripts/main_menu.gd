extends Control




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_pressed("shoot"):
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/level.tscn")
	if Input.is_action_pressed("settings"):
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://scenes/settings.tscn")
