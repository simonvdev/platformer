class_name HealthComponent extends Node

@export var maxhearts = 3
var currenthearts = 0
var state : HealthState = HealthState.Alive

@export
var hitBoxes : Array[HitBox2D]

signal health_changed(old : int,new : int, delta : int)
signal died()

enum HealthState {
	Alive,
	Dead
}

# Called when the node enters the scene tree for the first time.
func _ready():
	currenthearts = maxhearts
	link_to_hitboxes()
	
func link_to_hitboxes():
	for box in hitBoxes:
		box.handle_hit.connect(_on_hit)
	
func _on_hit(damage : DamageSource):
	change_health(damage)

func change_health(source : DamageSource):
	if state == HealthState.Dead:
		return

	var oldHealth = currenthearts
	currenthearts += source.damage
	
	currenthearts = clampi(currenthearts,0,maxhearts)
	
	health_changed.emit(oldHealth,currenthearts,currenthearts - oldHealth)
	
	if ( currenthearts <= 0 ):
		state = HealthState.Dead
		died.emit()
