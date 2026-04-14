extends Control

@onready var inven_section = $HBoxContainer/VBoxContainer2/Inventory/VBoxContainer
@onready var stats_section = $HBoxContainer/VBoxContainer/Stats
@onready var body_section = $HBoxContainer/VBoxContainer/Body
@onready var hands_section =  $HBoxContainer/VBoxContainer/Hands
@onready var inven = global.inventory

func _ready() -> void:
	update_stats()
	place_inventory_labels()


func place_inventory_labels() -> void:
	for i in inven_section.get_children():
		i.queue_free()
	
	for i in inven:
		var b = Button.new()
		b.text = i.Item_name
		inven_section.add_child(b)
		b.pressed.connect(on_inven_label_pressed.bind(b))


func update_stats() -> void:
	stats_section.text = "{player_name}

CHARISMA: {Charisma}
DETERMINATION: {Determination}
DEXTERITY: {Dexterity}
ENDURANCE: {Endurance}
STRENGTH: {Strength}
INTELLIGENCE: {Intelligence}

{money}Cr".format(global) #Waiter! Waiter! more codeslop!
	
	if global.body_equip != null:
		body_section.text = "Body: " + global.body_equip.Item_name
	else:
		body_section.text = "Body: --"
	
	if global.hands_equip != null:
		hands_section.text = "Hands: " + global.hands_equip.Item_name
	else:
		hands_section.text = "Hands: --"


func on_inven_label_pressed(button: Button):
	global.inventory.get(inven_section.get_children().find(button)).activate_item()
	update_stats()
	place_inventory_labels()


func _on_body_pressed() -> void:
	if global.body_equip != null:
		global.inventory.append(global.body_equip)
		global.body_equip = null
	update_stats()
	place_inventory_labels()


func _on_hands_pressed() -> void:
	if global.hands_equip != null:
		global.inventory.append(global.hands_equip)
		global.hands_equip = null
	update_stats()
	place_inventory_labels()
