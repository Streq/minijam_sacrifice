extends PathFollow2D


export var SPAWN : PackedScene
export var seconds := 5.0
export var start_at := 0.0
export var units := 10

onready var path = get_parent()
onready var timer = $timer
onready var start_timer = $start_timer

func _ready():
	start_timer.one_shot = true
	start_timer.wait_time = max(1.0/60.0, start_at)
	start_timer.start()

	yield(start_timer, "timeout")
	_timeout()
	
	timer.one_shot = false
	timer.wait_time = seconds
	timer.connect("timeout", self, "_timeout")
	timer.start()
	
	
	
func _timeout():
	var spawn = SPAWN.instance()
	path.add_child(spawn)
	units -= 1
	if !units:
		timer.stop()
