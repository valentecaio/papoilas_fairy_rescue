extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
    body.get_node("AnimatedSprite2D").play("death")
    body.get_node("CollisionShape2D").queue_free()
    body.get_node("CollisionShape2D2").queue_free()
    Global.player_lifes -= 1
