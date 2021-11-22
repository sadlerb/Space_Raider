extends Control

onready var scene_tree: = get_tree()
onready var pause_overlay: = $PauseOverlay
var paused: = false setget set_paused
onready var score:= get_node("Label")
onready var pause_title: Label = get_node("PauseOverlay/pause_title")
onready var final_score: Label = get_node("PauseOverlay/final_score")

func _physics_process(delta):
	update_interface()
	
func set_paused (value: bool):
	paused = value
	scene_tree.paused = value
	pause_overlay.visible = value

func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		pause_title.text = "Paused"
		self.paused = not paused
		scene_tree.set_input_as_handled()
func _ready():
	PlayerData.connect("score_updated",self,"user_interface")
	PlayerData.connect("player_died",self,"_PlayerData_player_died")
	update_interface()

func update_interface():
	score.text ="Score: %s" % PlayerData.score

func _PlayerData_player_died():
	self.paused = true
	pause_title.text = "You Died"
	pause_title.text = "Final Score: %s" % PlayerData.score


func _on_Quit_button_up():
	pass # Replace with function body.
