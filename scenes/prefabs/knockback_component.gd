class_name KnockbackComponent extends Node2D

@export var health_component : HealthComponent
@export var physics_body_2d : PhysicsBody2D

var knock_direction : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if health_component != null:
		health_component.hit.connect(_on_hit)

func _on_hit(damage : DamageSource):
	if damage.insitigator == null:
		return
	if physics_body_2d == null:
		return

	knock_direction = (global_position - damage.insitigator.global_position) 
	
	
	physics_body_2d.apply_knockback(knock_direction, damage.knockback_distance)
	queue_redraw()
	
	
func _draw() -> void:
	draw_line(position,position + (knock_direction.normalized() * 64),Color.RED,8)
