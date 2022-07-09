extends ProgressBar


func _ready():
	owner.connect("health_changed", self, "_on_health_changed")
	
func _on_health_changed(val, max_val):
	value = val
	max_value = max_val
