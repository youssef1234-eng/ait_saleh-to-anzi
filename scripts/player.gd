extends CharacterBody2D

var speed = 100
var player_state
var bow_equiped = true
var bow_cooldown = true
var arrow = preload("res://scenes/arrow.tscn")



@export var inv: Inv

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("left","right","up","down")
	
	
	if direction.x == 0 and direction.y == 0:
		player_state = "idle"
	elif direction.x != 0 or direction.y != 0:
		player_state = "walking"
	

	
	velocity = direction * speed
	
	move_and_slide()
	
	
	
	var mouse_pos = get_global_mouse_position()
	$Marker2D.look_at(mouse_pos)
	
	if Input.is_action_just_pressed("shoot") and bow_equiped and bow_cooldown:
		bow_cooldown = false
		var arrow_instance = arrow.instantiate()
		arrow_instance.rotation = $Marker2D.rotation
		arrow_instance.global_position = $Marker2D.global_position
		add_child(arrow_instance)
	
	
	await get_tree().create_timer(0.4).timeout
	bow_cooldown = true


	play_anim(direction)
	
func play_anim(dir):
	if player_state == "idle":
		$AnimatedSprite2D.play("idle")
	if player_state == "walking":
		if dir.y == -1:
			$AnimatedSprite2D.play("n_walk")
		if dir.x == 1:
			$AnimatedSprite2D.play("e_walk")
		if dir.y == 1:
			$AnimatedSprite2D.play("s_walk")
		if dir.x == -1:
			$AnimatedSprite2D.play("w_walk")
		
		if dir.x > 0.5 and dir .y < -0.5:
			$AnimatedSprite2D.play("ne_walk")
		if dir.x > 0.5 and dir .y > 0.5:
			$AnimatedSprite2D.play("se_walk")
		if dir.x < -0.5 and dir .y < -0.5:
			$AnimatedSprite2D.play("nw_walk")
		if dir.x < -0.5 and dir .y > 0.5:
			$AnimatedSprite2D.play("ws_walk")


func player():
	
	pass

func collect(item):
	inv.insert(item)
	
	
