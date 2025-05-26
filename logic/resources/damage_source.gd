extends Resource
class_name DamageSource

enum DamageType {
	Physical,
}

@export var damage : int
@export var damage_type : DamageType
@export var knockback_distance : int
var insitigator : Node2D

func _init(_damage = 1, _damageType : DamageType = DamageType.Physical , _knockback_distance : int = 0) -> void:
	damage = _damage
	knockback_distance = _knockback_distance
	damage_type = _damageType

static func fromStomp() -> DamageSource:
	return DamageSource.new(10,	DamageType.Physical)
