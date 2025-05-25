extends CanvasLayer

@onready var coin_label = $Control/HBoxContainer/Label

# Called when the node enters the scene tree for the first time.
func _ready():
	Director.CoinsChanged.connect(_on_coins_changed)
	
	
func _on_coins_changed(_old : int,new : int,_delta : int):
	coin_label.text = str(new)
