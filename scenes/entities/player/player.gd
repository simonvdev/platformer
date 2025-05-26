extends CharacterBody2D


@export var SPEED = 300.0
@export var JUMP_VELOCITY = -600.0
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var health_component : HealthComponent = $HealthComponent


@export var jump_sound : AudioStream
@onready var damage_volume: DamageVolume = $DamageVolume

func _ready():
	health_component.died.connect(_on_death)
	health_component.health_changed.connect(_health_changed)
	
func _on_death():
	Director.PlayerDied.emit()
	queue_free()
	
func _health_changed(old :int,new:int, delta:int):
	Director.PlayerHealthChanged.emit(old,new, delta)
	
# Handle animations and direction changes based on player velocity
func _process(delta):
	if not is_on_floor():
		if velocity.y > 0:
			animated_sprite_2d.play("falling")
		elif velocity.y < 0:
			animated_sprite_2d.play("jump")
	else:
		if velocity.x != 0:
			animated_sprite_2d.play("run")
		else:
			animated_sprite_2d.play("idle")	
			
	var direction = Input.get_axis("left", "right")
	
	if direction < 0:
		animated_sprite_2d.flip_h = true
	else:
		animated_sprite_2d.flip_h = false
		
func apply_knockback(direction : Vector2, distance : float):
	var gravity := get_gravity()  # This is a Vector2, usually (0, 980)
	var displacement := direction.normalized() * distance
	var duration := 0.2
	var initial_velocity := (displacement - 0.5 * gravity * duration * duration) / duration
	velocity+= initial_velocity

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		damage_volume.monitoring = true
	else:
		damage_volume.monitoring = false

	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y += JUMP_VELOCITY
		var test : AudioStreamPlayer = SoundManager.play_sound(jump_sound, "SFX")
		test.volume_linear = 0.5

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	move_and_slide()
