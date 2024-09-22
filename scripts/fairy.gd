extends Area2D

#@onready var game_manager = %GameManager
@onready var animation_player = $AnimationPlayer
@onready var animated_sprite_2d = $AnimatedSprite2D
@export var color : Color

func _on_body_entered(_body):
    animation_player.play("pickup")
    Global.player_fairies += 1
    
func _ready():
    animated_sprite_2d.material.set_shader_parameter("modulate", color)
    
