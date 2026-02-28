class_name Chest

extends Interactable

@export_range(0, 50_000, 1, "or_greater") var money: int
@export var storaged: Array[Item] = []

func player_entered() -> void:
	pass #chests are never trigger areas

func do_interaction() -> void:
	if storaged.is_empty():
		global.create_descriptor("There is nothing left...")
		return
	
	if money != 0:
		global.create_descriptor(str(money) + " credits added to inventory")
		global.money += money
	
	for i in storaged:
		global.create_descriptor(i.Item_name + " added to inventory")
	
	global.inventory.append_array(storaged)
	storaged.clear()
