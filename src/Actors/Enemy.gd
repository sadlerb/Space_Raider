extends Actor
export var shot_cooldown = 1.0

var player_location = PlayerData.current_position
export (PackedScene) var EnemyBlaster
var isAlive = true
var canAttack = false

var score = 100
onready var firepoint:Position2D =get_node("FirePoint")
onready var sprite: AnimatedSprite = get_node("AnimatedSprite")
onready var hitBox: CollisionShape2D = get_node("CollisionShape2D")
onready var player: AudioStreamPlayer2D = get_node("AudioStreamPlayer2D")

var explode = preload('res://src/Sounds/explode.wav')
export var attack_range = 200


var _timer = null


func _ready():
	_timer = Timer.new()
	add_child(_timer)

	_timer.connect("timeout", self, "_on_Timer_timeout")
	_timer.set_wait_time(shot_cooldown)
	_timer.set_one_shot(false) # Make sure it loops
	_timer.start()


func _on_Timer_timeout():
	canAttack = true
	
func _physics_process(delta):
	_move_to_player()
	player_location = PlayerData.current_position


func _move_to_player():
	var to_player = player_location - global_position
	var distance = to_player.length()
	var direction = to_player.normalized()


	if distance > attack_range:
		move_and_slide(direction * speed)
	else:
		attack()


	
func die():
	isAlive = false
	hitBox.set_deferred("disabled",true)
	sprite.play("explode")
	player.stream = explode
	player.play()
	PlayerData.set_score(score)
	
	yield(sprite,"animation_finished")
	queue_free()
	


func hit():
	health -=1
	if health == 0:
		die() 
		
func attack():
	if isAlive and canAttack:
		var bullet = EnemyBlaster.instance()
		owner.add_child(bullet)
		bullet.transform = firepoint.get_global_transform()
		canAttack = false
