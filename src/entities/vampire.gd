extends KinematicBody2D


export var speed := 100.0
export var RAY : PackedScene

export var health := 100.0 setget set_health
export var max_health := 100.0

onready var input_state = $input_state
onready var ray_cooldown = $ray_cooldown


var velocity := Vector2()
var team = Team.TEAM.PLAYER


var can_shoot = true

func _ready():
	ray_cooldown.connect("timeout",self,"cooldown_over")


func cooldown_over():
	can_shoot = true

func _physics_process(delta):
	var dir = input_state.dir
	velocity = dir*speed
	velocity = move_and_slide(velocity)
	if input_state.shoot:
		call_deferred("shoot")


func shoot():
	if can_shoot:
		can_shoot = false
		var ray = RAY.instance()
		ray.shooter = self
		get_tree().current_scene.add_child(ray)
		ray.rotation = (input_state.global_aim-global_position).angle()
		ray.global_position = global_position
		ray_cooldown.start()

func die():
	get_tree().reload_current_scene()

func set_health(val):
	health = clamp(val, 0, max_health)
	emit_signal("health_changed", health, max_health)
	if !health:
		die()
	
