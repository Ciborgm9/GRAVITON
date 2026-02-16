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
		
		if Input.is_action_just_pressed("ui_accept"): interact_with_contact()

func _on_inter_ray_body_entered(body: Node2D) -> void:
	if body is Interactable:
		contact = body
		if body.trigger_area:
			interact_with_contact()
			body.queue_free() #triggers are deleted after one interaction

func _on_inter_ray_body_exited(body: Node2D) -> void:
	if body == contact: contact = null
	#Is there really no better way to do this?

func interact_with_contact() -> void:
	if contact != null:
		if contact.dialogue != null:
			DialogueManager.show_dialogue_balloon(contact.dialogue)
		else:
			add_child(global.create_descriptor(contact.quote))
