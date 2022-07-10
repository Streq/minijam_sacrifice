extends Node2D

export var damage = 10.0


onready var reach = $range
onready var cooldown = $cooldown

var can_hit = true

func _physics_process(delta):
	var target = null
	if can_hit:
		for hurtbox in reach.get_overlapping_areas():
			if hurtbox.owner.team != owner.team:
				target = hurtbox.owner
				break
		if target:
			owner.can_move = false
			can_hit = false
			target.health -= damage
			cooldown.start()


func _on_cooldown_timeout():
	owner.can_move = true
	can_hit = true
