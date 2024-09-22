extends Node3D

@onready var stage_2d: Node2D = $Tower/Stage2DSubViewport/Stage2D
var door

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    door = stage_2d.get_node("Door")
    door.connect("door_entered", _on_door_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass
    
func _on_door_entered() -> void:
    print("world3D:door_entered")
    await get_tree().create_timer(1.0).timeout
    get_tree().change_scene_to_file("res://scenes/elevator_cutscene.tscn")
