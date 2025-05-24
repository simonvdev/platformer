class_name DamageVolume extends HitBox2D

@export var volumeDamage : DamageSource

func on_hit_box_entered(hitBox : HitBox2D) -> void:
	if volumeDamage != null:
		hitBox.hit(volumeDamage)
