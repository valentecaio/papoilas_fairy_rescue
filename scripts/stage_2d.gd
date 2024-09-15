class_name Stage2D extends Node2D

@onready var player = $Player

signal player_position_changed(cur_player_pos)

func _process(_delta):
    player_position_changed.emit(player.position)
