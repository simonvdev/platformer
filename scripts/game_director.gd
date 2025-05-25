extends Node

class_name GameDirector

@export var PlayerPrefab : PackedScene

signal LevelFinished
signal CoinCollected
signal CoinsChanged(old : int,new : int,delta : int)
signal RespawnPlayer(position)
signal PlayerHealthChanged(old : int ,new : int, delta: int)
signal PlayerDied

signal NewCheckpoint(position : Vector2)

var last_checkpoint : Vector2

var AmountOfCoinsCollected : int = 0

func _init():
	LevelFinished.connect(_on_level_finished)
	CoinCollected.connect(_on_coin_collected)
	CoinsChanged.connect(_on_coins_changed)
	PlayerDied.connect(_on_player_died)
	NewCheckpoint.connect(_on_new_checkpoint)
	
func _on_coin_collected():
	AmountOfCoinsCollected += 1
	CoinsChanged.emit(AmountOfCoinsCollected - 1,AmountOfCoinsCollected,1)	

func _on_coins_changed(_old : int,new : int, _delta:int ):
	print("Coins: " + str(new))

func _on_new_checkpoint(position : Vector2):
	last_checkpoint = position

func _on_player_died():
	if PlayerPrefab == null:
		print ("Player prefab not assigned for respawn")
		return
	
	# Instantiate new player
	var player : Node2D = PlayerPrefab.instantiate()
	get_tree().root.add_child(player)
	player.position = last_checkpoint
	
	# Camera
	var camera_follower = get_tree().get_first_node_in_group("camera")
	if camera_follower is CameraFollower2D:
		camera_follower.retarget(player)

func _on_level_finished():
	print("Level Done")
	AmountOfCoinsCollected = 0
