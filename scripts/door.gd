extends Area2D

signal door_entered()

func _on_body_entered(_body):
    print("door_entered")
    door_entered.emit()
