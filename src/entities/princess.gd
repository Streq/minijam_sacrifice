extends Area2D


var taken = false
var holder = null

func taken_by(taker):
	holder = taker
	taken = true
	NodeUtils.reparent(self, taker)
	self.position = Vector2.ZERO
	
func dropped_by(dropper):
	if holder == dropper:
		holder = null
		taken = false
		NodeUtils.reparent_keep_transform(self, get_tree().current_scene)
