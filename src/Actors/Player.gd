extends Actor



onready var sprite : AnimatedSprite = get_node("player")
onready var firepoint:Position2D = get_node("FirePoint")
onready var audio_player:AudioStreamPlayer2D = get_node("AudioStreamPlayer2D")

var shoot = preload('res://src/Sounds/shoot.wav')
var blink = preload('res://src/Sounds/teleport.wav')
var hit = preload('res://src/Sounds/player_hit.wav')



export (PackedScene) var Bullet
export var shot_cooldown = 0
export var blink_cooldown = 0

	
func _physics_process(delta):
	var mouse_position = get_global_mouse_position()
	shot_cooldown -=1 if shot_cooldown > 0 else 0
	blink_cooldown -=1 if blink_cooldown > 0 else 0
	_look_at_mouse(mouse_position)
	if Input.is_action_pressed("foward") and !Input.is_action_pressed("stall"):
		_move_to_mouse(mouse_position)
	elif Input.is_action_pressed("stall"):
		sprite.play("default")
		stall()
	else:
		sprite.play("default")
		_velocity = _velocity*0.99
		move_and_slide(_velocity)
		
	if Input.is_action_just_released("blink"):
		blink(mouse_position)
		
		
	if Input.is_action_pressed("fire")and !Input.is_action_pressed("defend"):
		shoot()
	
	
	PlayerData.set_position(global_position)
	
func _move_to_mouse(mouse_postion:Vector2) ->void:
	var direction = mouse_postion - position
	sprite.play("move")
	_velocity = _calculate_movement(direction,speed)
	move_and_slide(_velocity)
	
func _look_at_mouse(mouse_postion:Vector2) -> void:
	look_at(mouse_postion)
	rotation_degrees += 90
	
	

func _calculate_movement(direction:Vector2,speed:int) -> Vector2:
	return direction * speed
	
	
func shoot():
	if shot_cooldown == 0:
		var bullet = Bullet.instance()
		owner.add_child(bullet)
		bullet.transform = firepoint.get_global_transform()
		audio_player.stream = shoot
		audio_player.play()
		shot_cooldown = 10

func blink(blink_location):
	if blink_cooldown == 0:
		audio_player.stream = blink
		audio_player.play()
		position = blink_location
		blink_cooldown = 200

func stall():
	move_and_slide(_velocity)
	_velocity = _velocity * 0.99
	
func hit():
	audio_player.stream = hit
	audio_player.play()
	health -=1
	if health ==0:
		sprite.play("die")
		yield(sprite,"animation_finished")
		die()


