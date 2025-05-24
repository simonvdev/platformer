extends Resource
class_name DamageSource

enum DamageType {
	Physical,
}

@export var damage : int
@export var damage_type : DamageType
var knockback : Vector2

func _init(_damage = 1, _damageType : DamageType = DamageType.Physical , _knockback = Vector2.ZERO) -> void:
	damage = _damage
	knockback = _knockback
	damage_type = _damageType

static func fromStomp() -> DamageSource:
	return DamageSource.new(10,	DamageType.Physical)
