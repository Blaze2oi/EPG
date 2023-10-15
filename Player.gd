extends CharacterBody2D


const UP = Vector2(0,-1)
const FLAP = 200
const MAXFALLSPEED = 200
const GRAVITY = 10

var motion = Vector2()
var Wall = preload("res://wallnode.tscn")
var score = 0

func _ready():
	pass 
func _physics_process(delta):
	
	velocity.y += GRAVITY
	if velocity.y > MAXFALLSPEED:
		velocity.y = MAXFALLSPEED
		
	if Input.is_action_just_pressed("FLAP"):
		velocity.y = -FLAP
		
	motion = move_and_slide()
	
	get_parent().get_parent().get_node("CanvasLayer/RichTextLabel").text = str(score)


func Wall_reset():
	var Wall_instance = Wall.instance()
	Wall_instance.position = Vector2(450,randf_range(-60,60))
	get_parent().call_deferred("add_child",Wall_instance)
func _on_Resetter_body_entered(body):
	if body.name == "Walls":
		body.queue_free()
		Wall_reset()


func _on_detect_area_entered(area):
	if area.name == "PointArea":
		score += 1


func _on_detect_body_entered(body):
	if body.name == "Walls":
		get_tree().reload_current_scene()
