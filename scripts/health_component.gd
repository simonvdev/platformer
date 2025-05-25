class_name HealthComponent extends Node

@export var maxhearts = 6
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
	link_to_hitboxes()
	set_health(maxhearts)
	
func link_to_hitboxes():
	for box in hitBoxes:
		box.handle_hit.connect(_on_hit)
		
func _on_hit(damage : DamageSource):
	change_health(damage)
	
func set_health(value : int):
	var oldHealth = currenthearts
	currenthearts = value
	
	currenthearts = clampi(currenthearts,0,maxhearts)
	
	health_changed.emit.call_deferred(oldHealth,currenthearts,currenthearts - oldHealth)
	
	if ( currenthearts <= 0 ):
		state = HealthState.Dead
		died.emit.call_deferred()

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
