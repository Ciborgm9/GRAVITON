class_name Descriptor

extends Label

@onready var yanderedev_would_be_so_proud: float = 0
var life_time: int
var shadow: ColorRect

func _init(message: String) -> void:
	text = message
	life_time = 8

func _ready() -> void:
	pivot_offset = size/2
	scale *= 2
	position = Vector2(-1725, -940)
	self.z_index = 100 #What The Fuck
	
	shadow = ColorRect.new()
	shadow.color = Color(0, 0, 0, 0.6)
	shadow.z_index = -1
	shadow.scale = self.scale
	shadow.size = self.size + Vector2(5, 5)
	shadow.pivot_offset = self.pivot_offset
	add_child(shadow)
	
	# I really need to redo this entire thing

func _process(delta: float) -> void:
	yanderedev_would_be_so_proud += delta
	if yanderedev_would_be_so_proud > life_time: #Seconds until descriptor gets deleted
		modulate.a -= delta/2
		if modulate.a <= 0:
			global.noti_list.erase(self)
			queue_free()
