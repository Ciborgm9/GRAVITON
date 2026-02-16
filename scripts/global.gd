extends Node

signal new_descriptor_created(d: Descriptor)

@onready var lock_player: bool = false

var player_name: String = "The Player" #Tarpheley?
var inventory: Array[Item] = []
var ship_name: String = "Galaxy Driver"
var money: int = 100

var player_spawn: Vector2 = Vector2.ZERO

var Academics: int = 5
var Charisma: int = 5
var Dexterity: int = 5
var Endurance: int = 5
var Perception: int = 5
var Science: int = 5
var Strength: int = 5
var Tech: int = 5

func _ready() -> void:
	new_descriptor_created.connect(DescHandler.on_new_desc_created)
	DialogueManager.dialogue_started.connect(dialogue_started)
	DialogueManager.dialogue_ended.connect(dialogue_ended)

func create_descriptor(text: String) -> Descriptor:
	var d = Descriptor.new(text)
	new_descriptor_created.emit(d)
	return d

func dialogue_started(_r: Resource) -> void: 
	lock_player = true 

func dialogue_ended(_r: Resource) -> void: 
	await get_tree().create_timer(0.1, false, true).timeout
	lock_player = false
#The signals return the resource, so i dont know what to do with it
