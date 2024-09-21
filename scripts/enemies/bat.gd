extends Node2D

@export var speed := 40
var direction := 1

@onready var animated_sprite = $AnimatedSprite
@onready var ray_cast_1 = $RayCast1
@onready var ray_cast_2 = $RayCast2
@onready var jumpzone = $Jumpzone
@onready var killzone = $Killzone


func _ready():
    jumpzone.body_entered.connect(_on_jumpzone_body_entered)


func _process(delta):
    # movement
    if ray_cast_1.is_colliding():
        direction = -1
    if ray_cast_2.is_colliding():
        direction = 1
    position.y += direction * speed * delta

    # sprite flipping
    animated_sprite.flip_h = Global.player_position.x < position.x


func _on_jumpzone_body_entered(body):
    print("bat jumpzone hit")
    if body.has_method("bounce"):
        body.bounce()
        # TODO: play death animation
        # killzone.get_node("CollisionShape2D").disabled = true
        # animated_sprite.play("hit")
        queue_free()
