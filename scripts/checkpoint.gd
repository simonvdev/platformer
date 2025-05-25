class_name Checkpoint extends Area2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var activated : bool = false

func _ready() -> void:
	body_entered.connect(_body_entered)
	animated_sprite_2d.play("default")
	
func _body_entered(body : Node2D):
	if activated == false:
		Director.NewCheckpoint.emit(self.position)
		activated = true
