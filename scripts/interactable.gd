class_name Interactable

extends StaticBody2D

@export_multiline var quote: String = "Blah blah blah"
@export var dialogue: Resource
@export var physical_object: bool = true
@export var trigger_area: bool = false

func _ready() -> void: #Should we use ready or init for this?
	if trigger_area: physical_object = false #triggers are never physical objects
	if !physical_object: set_collision_layer_value(1, false)
	set_collision_layer_value(2, true)
