# Global autoload

extends Node
# width of stage, used to wrap player and enemies around the screen
const stage_w := 1024

signal open_hatch()

var fairy_soundplayer = preload("res://scenes/fairy_sound.tscn").instantiate()
var coin_soundplayer = preload("res://scenes/coin_sound.tscn").instantiate()

### player stats ###qe
var player_coins :
    set(value):
        player_coins = value
        coin_soundplayer.play()
    get():
        return player_coins
        
var player_fairies :
    set(value):
        player_fairies = value
        fairy_soundplayer.play()
        if value == 5:
            open_hatch.emit()
    get():
        return player_fairies
            
var player_kills := 0

# current player position, used by enemies to track player
var player_position: Vector2:
    set(pos):
      player_position = pos
      # wrap player around the screen
      if player_position.x < 0:
        player_position.x = stage_w + pos.x


func _ready():
    player_fairies = 0
    player_coins = 0
    add_child(fairy_soundplayer)
    add_child(coin_soundplayer)
    
