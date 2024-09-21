extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
    body.get_node("AnimatedSprite2D").play("death")
    body.get_node("CollisionShape2D").queue_free()
    body.get_node("CollisionShape2D2").queue_free()
    Engine.time_scale = 0.5
    timer.start()

func _on_timer_timeout():
    Engine.time_scale = 1
    get_tree().reload_current_scene()
