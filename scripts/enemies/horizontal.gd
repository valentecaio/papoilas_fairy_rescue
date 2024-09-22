extends Node2D

@export var speed := 60
var direction := 1

@onready var animated_sprite = $AnimatedSprite
@onready var ray_cast_right = $Rays/RayCastRight
@onready var ray_cast_left = $Rays/RayCastLeft
@onready var jumpzone = $Jumpzone
@onready var killzone = $Killzone

enum State { ALIVE, HIT, DEAD }
var state = State.ALIVE

func _ready():
    jumpzone.body_entered.connect(_on_jumpzone_body_entered)


func _process(delta):
    if ray_cast_right.is_colliding():
        direction = -1
        animated_sprite.flip_h = true
    if ray_cast_left.is_colliding():
        direction = 1
        animated_sprite.flip_h = false
    position.x += direction * speed * delta


func _on_jumpzone_body_entered(body):
    if body.has_method("bounce"):
        body.bounce()
        # TODO: play death animation
        # killzone.get_node("CollisionShape2D").disabled = true
        # animated_sprite.play("hit")
        queue_free()
