# Global autoload

extends Node

# width of stage, used to wrap player and enemies around the screen
const stage_w := 1024

signal open_hatch()

### player stats ###
var player_coins := 0
var player_fairies :
    set(value):
        player_fairies = value
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
