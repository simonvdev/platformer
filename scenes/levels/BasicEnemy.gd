extends CharacterBody2D


var SPEED = 175.0
var direction = -1
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_component: HealthComponent = $HealthComponent
@onready var damage_volume: DamageVolume = $DamageVolume

func _ready() -> void:
	health_component.died.connect(_on_death)

func _on_death():
	animated_sprite_2d.play("squished")
	SPEED = 0
	damage_volume.monitoring = false
	await get_tree().create_timer(0.25).timeout
	queue_free()

func _process(delta: float) -> void:
	animated_sprite_2d.flip_h = true if direction == 1 else false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	if ray_cast_2d.is_colliding():
		var dir = ray_cast_2d.get_collision_point() - ray_cast_2d.global_position
		if dir.length() < 40 :
			direction *= -1
			ray_cast_2d.target_position.x *= -1	 

	velocity.x = SPEED * direction

	move_and_slide()
