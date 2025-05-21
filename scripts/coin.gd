extends Area2D
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var audio_stream_player_2d = $AudioStreamPlayer2D
@onready var collision_shape_2d = $CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite_2d.play("default")
	body_entered.connect(_on_body_entered)
	audio_stream_player_2d.finished.connect(_on_audio_finished)
	
	
func _on_body_entered(body):
	Director.CoinCollected.emit()
	audio_stream_player_2d.play()
	collision_shape_2d.disabled = true
	animated_sprite_2d.visible = false

func _on_audio_finished():
	queue_free()
