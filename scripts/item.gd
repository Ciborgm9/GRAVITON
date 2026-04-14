@abstract class_name Item

extends Resource

var Item_name: String
var Item_desc: String
var Item_type: global.Item_types_enum

func _action() -> void:
	return

func activate_item() -> void:
	_action()
	match Item_type:
		global.Item_types_enum.WEARABLE:
			global.inventory.erase(self)
			global.body_equip = self
		global.Item_types_enum.TOOL:
			global.inventory.erase(self)
			global.hands_equip = self
		global.Item_types_enum.CONSUMABLE:
			global.inventory.erase(self)
			free()
