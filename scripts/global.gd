# Global autoload

extends Node

# used by enemies to track player
var player_position: Vector2:
    set(pos):
      player_position = pos
      if player_position.x < 0:
        player_position.x = stage_w + pos.x


# used to wrap player and enemies around the screen
var stage_w := 1024
