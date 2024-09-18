extends Node2D

@export var speed := 60
var direction := 1

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var ray_cast_2d_right = $RayCast2DRight
@onready var ray_cast_2d_left = $RayCast2DLeft
@onready var jumpzone = $Jumpzone
@onready var killzone = $Killzone


func _ready():
    jumpzone.body_entered.connect(_on_jumpzone_body_entered)


func _process(delta):
    if ray_cast_2d_right.is_colliding():
        direction = -1
        animated_sprite_2d.flip_h = true
    if ray_cast_2d_left.is_colliding():
        direction = 1
        animated_sprite_2d.flip_h = false
    position.x += direction * speed * delta


func _on_jumpzone_body_entered(body):
    if body.has_method("bounce"):
        body.bounce()
        # TODO: play death animation
        queue_free()
