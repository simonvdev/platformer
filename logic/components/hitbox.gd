class_name HitBox2D extends Area2D

## emitted when collision with [HitBox2D] detected.
signal hit_box_entered(hit_box: HitBox2D)

signal handle_hit(damage : DamageSource)

## Ignore collisions when [color=orange]true[/color].[br]
## Set this to [color=orange]true[/color] after a collision is detected to avoid
## further collisions.[br]
## It is recommended to set this to [color=orange]true[/color] before calling
## [color=orange]queue_free()[/color] to avoid further collisions.
@export var ignore_collisions: bool

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func hit(damage : DamageSource):
	handle_hit.emit(damage)

## Detect collisions with [HitBox2D] or [HurtBox2D] and apply appropriate action.
func _on_area_entered(area: Area2D) -> void:
	if ignore_collisions:
		return
	
	if area is HitBox2D:
		on_hit_box_entered(area)
		hit_box_entered.emit(area)
		return

func on_hit_box_entered(_hitBox : HitBox2D):
	pass
