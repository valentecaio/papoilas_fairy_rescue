extends Node2D

@onready var fairy_1: Area2D = $Fairy1
@onready var fairy_2: Area2D = $Fairy2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    fairy_1.get_node("AnimatedSprite2D").flip_h = true
    fairy_2.get_node("AnimatedSprite2D").flip_h = true
