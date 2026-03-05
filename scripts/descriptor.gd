class_name Descriptor

extends Label

@onready var yanderedev_would_be_so_proud: float = 0
var life_time: int
var shadow: ColorRect

func _init(message: String) -> void:
	text = message
	life_time = 8

func _ready() -> void:
	position = Vector2(-1745, -940)
	z_index = 100 #What The Fuck
	shadow = ColorRect.new()
	shadow.position += Vector2(-15, -15)
	shadow.color = Color(0, 0, 0, 0.6)
	shadow.z_index = -1
	shadow.size = self.size + Vector2(30, 30)
	add_child(shadow)
	scale *= 2

func _process(delta: float) -> void:
	yanderedev_would_be_so_proud += delta
	if yanderedev_would_be_so_proud > life_time: #Seconds until descriptor gets deleted
		modulate.a -= delta/2
		if modulate.a <= 0:
			global.noti_list.erase(self)
			queue_free()
