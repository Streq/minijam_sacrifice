extends Area2D


export var damage := 10
export var speed := 100.0
var shooter = null

func _physics_process(delta):
	move_local_x(delta*speed)



func _on_ray_area_entered(area):
	var target = area.owner
	if shooter != target and shooter.team != target.team:
		target.health -= damage
		queue_free()
	
	
