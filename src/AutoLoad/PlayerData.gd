extends Node


signal player_moved
signal player_died
signal score_updated

var score: = 0 setget set_score
var current_position:= Vector2(0,0) setget set_position, get_position
var isAlive:= true setget setStatus


func set_position(position):
	current_position=position
	emit_signal("player_moved")
	
	
func get_position() -> Vector2:
	return current_position
	
func set_score(value:int) -> void:
	score += value
	emit_signal("score_updated")
	
func reset():
	score = 0
	
func setStatus(status):
	isAlive = status
	emit_signal("player_died")
