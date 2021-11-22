extends "res://src/Actors/Enemy.gd"

func _physics_process(delta):
	point_at_player()
	_move_to_player()
	
func point_at_player():
	look_at(player_location)
	rotation_degrees +=90
	

