class_name Interactable

extends StaticBody2D

@export_multiline var quote: String = "Blah blah blah"
@export var dialogue: Resource
@export var physical_object: bool = true
@export var trigger_area: bool = false


func _ready() -> void: #Should we use ready or init for this?
	if trigger_area or !physical_object: #triggers are never physical objects
		set_collision_layer_value(1, false)
	set_collision_layer_value(2, true)

func player_entered() -> void:
	if trigger_area:
		do_interaction()
		queue_free()  #triggers are deleted after one interaction

func space_pressed() -> void:
	do_interaction()

func do_interaction() -> void:
	if dialogue != null:
		DialogueManager.show_dialogue_balloon(dialogue)
	else:
		global.create_descriptor(quote)
