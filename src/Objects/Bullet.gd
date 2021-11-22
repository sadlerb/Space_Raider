extends Area2D
export var speed = 750
export var lifetime = 100





func _physics_process(delta):
	position -= transform.y * speed * delta
	lifetime -=1
	if lifetime == 0:
		queue_free()
	

func _on_body_entered(body):
	if body.is_in_group("enemy"):
		body.hit()
		queue_free()
	
	
	
