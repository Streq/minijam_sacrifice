extends PathFollow2D

signal health_changed(val,max_val)

export var speed := 50.0
export var go_forward = true
export var health := 100.0 setget set_health
export var max_health := 100.0
export (Team.TEAM) var team : = Team.TEAM.ENEMY


onready var _offset = offset
onready var can_take_cooldown = $can_take_cooldown

var with_princess = false
var princess = null
var can_take_princess = true



func _ready():
	set_health(health)

func _physics_process(delta):
	var move = speed*delta*Bool.sign(!go_forward)
	offset += move
#	print (offset)
	if unit_offset == 1.0 or with_princess:
		go_forward = false
	elif unit_offset == 0.0:
		queue_free()

func set_health(val):
	health = clamp(val, 0, max_health)
	emit_signal("health_changed", health, max_health)
	if !health:
		die()
	
func die():
	yield(get_tree(),"idle_frame")
	if with_princess:
		drop_princess()
	queue_free()
func drop_princess():
	princess.dropped_by(self)
	with_princess = false
	can_take_princess = false
	can_take_cooldown.start()
	

func take_princess(princess):
	princess.taken_by(self)
	with_princess = true
	self.princess = princess

func _on_princess_area_entered(princess):
	if !princess.taken and can_take_princess:
		take_princess(princess)


func _on_can_take_cooldown_timeout():
	can_take_princess = true
