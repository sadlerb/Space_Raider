extends "res://src/Actors/Enemy.gd"
onready var cannon1 = get_node("FirePoint")
onready var cannon2 = get_node("FirePoint2")
onready var cannon3 = get_node("FirePoint3")
onready var cannon4 = get_node("FirePoint4")


onready var anim_player = get_node("AnimationPlayer")

func _init(_shot_cooldown = 1.2).():
	shot_cooldown = _shot_cooldown
	score = 300
	
func die():
	isAlive = false
	hitBox.set_deferred("disabled",true)
	anim_player.play("explode")
	player.stream = explode
	player.play()
	yield(anim_player,"animation_finished")
	PlayerData.set_score(score)
	queue_free()
	
func _physics_process(delta):
	_move_to_player()

func attack():
	if isAlive and canAttack:
		var bullet = EnemyBlaster.instance()
		var bullet1 = EnemyBlaster.instance()
		var bullet2 = EnemyBlaster.instance()
		var bullet3 = EnemyBlaster.instance()
		
		owner.add_child(bullet)
		owner.add_child(bullet1)
		owner.add_child(bullet2)
		owner.add_child(bullet3)
		bullet.transform = cannon1.get_global_transform()
		bullet1.transform = cannon2.get_global_transform()
		bullet2.transform = cannon3.get_global_transform()
		bullet3.transform = cannon4.get_global_transform()
		
		canAttack = false
