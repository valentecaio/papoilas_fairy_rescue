extends Node2D

@onready var animated_sprite = $AnimatedSprite
@onready var jumpzone = $Jumpzone
@onready var killzone = $Killzone


func _ready():
    jumpzone.body_entered.connect(_on_jumpzone_body_entered)


func _process(_delta):
    # sprite flipping
    animated_sprite.flip_h = Global.player_position.x < position.x


func _on_jumpzone_body_entered(body):
    if body.has_method("bounce"):
        body.bounce()
        # TODO: play death animation
        # killzone.get_node("CollisionShape2D").disabled = true
        # animated_sprite.play("hit")
        queue_free()
