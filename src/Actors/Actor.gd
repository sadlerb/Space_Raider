extends KinematicBody2D
class_name Actor

export var health: int  = 2
export var speed: float = 2.0

var _velocity: = Vector2.ZERO
const FLOOR_NORMAL: = Vector2.UP


func _on_BulletDetector_body_entered(body):
	print("body entered")
	health -=1
	if health == 0:
		die()
		
func die():
	PlayerData.setStatus(false)
	queue_free()
