extends Area2D
@onready var animated_sprite_2d = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite_2d.play("default")
	body_entered.connect(_on_body_entered)
	
	
func _on_body_entered(body):
	Director.CoinCollected.emit()
	queue_free()
