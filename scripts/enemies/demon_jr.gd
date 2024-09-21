extends CharacterBody2D

@export var speed := 20
var direction := 1

@onready var animated_sprite = $AnimatedSprite
@onready var ray_cast_1 = $RayCast1
@onready var ray_cast_2 = $RayCast2
@onready var jumpzone = $Jumpzone
@onready var killzone = $Killzone


func _ready():
    jumpzone.body_entered.connect(_on_jumpzone_body_entered)


func _process(delta):
    # gravity
    if not is_on_floor():
      velocity += 0.85 * get_gravity() * delta

    # follow player
    if abs(Global.player_position.x - position.x) <= 1:
        direction = 0
    elif Global.player_position.x < position.x:
        direction = -1 if not ray_cast_2.is_colliding() else 0
    else:
        direction = 1 if not ray_cast_1.is_colliding() else 0
    position.x += direction * speed * delta

    # sprite flipping
    animated_sprite.flip_h = Global.player_position.x < position.x


func _on_jumpzone_body_entered(body):
    print("demon_jr jumpzone hit")
    if body.has_method("bounce"):
        body.bounce()
        # TODO: play death animation
        # killzone.get_node("CollisionShape2D").disabled = true
        # animated_sprite.play("hit")
        queue_free()
