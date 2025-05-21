extends Node

class_name GameDirector

signal LevelFinished
signal CoinCollected
signal CoinsChanged(old : int,new : int,delta : int)

var AmountOfCoinsCollected : int = 0

func _ready():
	LevelFinished.connect(_on_level_finished)
	CoinCollected.connect(_on_coin_collected)
	CoinsChanged.connect(_on_coins_changed)
	
func _on_coin_collected():
	AmountOfCoinsCollected += 1
	CoinsChanged.emit(AmountOfCoinsCollected - 1,AmountOfCoinsCollected,1)	

func _on_coins_changed(old : int,new : int, delta:int ):
	print("Coins: " + str(new))

func _on_level_finished():
	print("Level Done")
	AmountOfCoinsCollected = 0
	get_tree().reload_current_scene()
