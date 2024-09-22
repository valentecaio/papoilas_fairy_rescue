extends Area2D

@onready var timer = $Timer

func _on_body_entered(body):
    if body.has_method("die"):
      body.die()
    Global.player_lifes -= 1
