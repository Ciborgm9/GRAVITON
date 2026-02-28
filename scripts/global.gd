extends Node

@onready var lock_player: bool = false

@onready var noti_list: Array[Descriptor] = []

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
	DialogueManager.dialogue_started.connect(dialogue_started)
	DialogueManager.dialogue_ended.connect(dialogue_ended)

func create_descriptor(text: String) -> void:
	var d = Descriptor.new(text)
	get_viewport().get_camera_2d().add_child(d)
	
	if noti_list.size() >= 12: #Deletes notifications if its more than 11
		var n = noti_list.get(11)
		noti_list.remove_at(11)
		n.queue_free()
	
	noti_list.push_front(d)
	var h = d.shadow.size.y + 110
	for i in noti_list:
		if noti_list.find(i) == 0:
			pass
		else:
			i.position.y += h

func dialogue_started(_r: Resource) -> void: 
	lock_player = true 

func dialogue_ended(_r: Resource) -> void: 
	await get_tree().create_timer(0.1, false, true).timeout
	lock_player = false
#The signals return the resource, so i dont know what to do with it
