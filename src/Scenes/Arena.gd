extends Node2D

export (PackedScene) var fighter
export (PackedScene) var destroyer
export var minOffset = 700	
export var maxOffset = 1000
var destroyer_spawn = 3

func _on_Timer_timeout():
	spawn(fighter)
	destroyer_spawn -=1
	if destroyer_spawn <= 0:
		spawn(destroyer)

	
func spawn(_enemy) -> void:
  # Creates a new instance of the _spawn_scene
	var spawn  = _enemy.instance() as Node2D

	add_child(spawn)
	
	spawn.set_as_toplevel(true)
	spawn.set_owner(self)



	spawn.global_position = get_random_spawn_position()

func get_random_spawn_position () -> Vector2:
	var to_player = PlayerData.current_position
	
	var y 
	var x
	y = rand_range(to_player.y + minOffset,to_player.y + maxOffset) if to_player.y > 0 else rand_range(to_player.y - minOffset,to_player.y - maxOffset)
	x = rand_range(to_player.x + minOffset,to_player.x + maxOffset) if to_player.x > 0 else rand_range(to_player.x - minOffset,to_player.x - maxOffset)
	
	return Vector2 (x,y)
