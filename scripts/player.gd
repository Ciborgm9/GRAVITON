class_name Player

extends CharacterBody2D

var contact = null

func _ready() -> void:
	if global.player_spawn != Vector2.ZERO: position = global.player_spawn

func _physics_process(_delta: float) -> void:
	
	if Input.is_action_just_pressed("ui_cancel"): get_tree().quit()
	
	if !global.lock_player:
		
		var direction = Input.get_vector("walk_left", "walk_right", "walk_up", "walk_down")
		velocity = direction * 300
		velocity.y /= 2 #cause its isometric view
		
		if Input.is_action_pressed("walk_left"):
			$InterRay.rotation = PI/2
			$InterRay.scale.y = 4.0
		if Input.is_action_pressed("walk_right"):
			$InterRay.rotation = (3*PI)/2
			$InterRay.scale.y = 4.0
		if Input.is_action_pressed("walk_up"):
			$InterRay.rotation = PI
			$InterRay.scale.y = 2.0
		if Input.is_action_pressed("walk_down"):
			$InterRay.rotation = 0
			$InterRay.scale.y = 2.0
		
		move_and_slide()
		#Bug where if you slide at a specific angle it starts doing weird stuff.
		#If not fixed, this bug will be exploited by future speedrunners.
		
		if Input.is_action_just_pressed("ui_accept"):
			if contact is Interactable: contact.space_pressed()

func _on_inter_ray_body_entered(body: Node2D) -> void:
	if body is Interactable: 
		contact = body
		contact.player_entered()

func _on_inter_ray_body_exited(body: Node2D) -> void:
	if body == contact: contact = null
	#Is there really no better way to do this?
