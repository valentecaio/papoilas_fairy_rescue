extends Area2D

#@onready var game_manager = %GameManager
@onready var animation_player = $AnimationPlayer

func _on_body_entered(_body):
    animation_player.play("pickup")
    Global.player_fairies += 1
