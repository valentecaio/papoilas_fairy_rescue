extends Node2D

@onready var player = $Player

signal player_position_changed(cur_player_pos)

func _process(delta):
  emit_signal("player_position_changed", player.position)
