class_name Checkpoint extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var activated : bool = false

@export var checkpoint_audio : AudioStream

func _ready() -> void:
	body_entered.connect(_body_entered)

	
func _body_entered(body : Node2D):
	if activated == false:
		# activate animation
		animated_sprite_2d.play("default")
		
		# play audio
		var stream : AudioStreamPlayer = SoundManager.play_sound(checkpoint_audio,"SFX")
		stream.volume_linear = 0.5
		
		# Notify game director
		Director.NewCheckpoint.emit(self.position)
		activated = true
