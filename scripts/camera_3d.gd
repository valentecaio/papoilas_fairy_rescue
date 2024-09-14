extends Camera3D

@onready var base = $"../Tower/Base"

@export var distance := 15

func _physics_process(delta: float) -> void:
  var dir = Input.get_axis("turn_left", "turn_right")
  if dir:
    base.rotate(Vector3(0,1,0), deg_to_rad(-dir*delta*50))

func _on_stage_2d_player_position_changed(cur_player_pos):
  var angle = deg_to_rad(cur_player_pos.x * 360.0 / 256)
  position.x = distance * sin(angle)
  position.z = distance * cos(angle)
  position.y = (1 - cur_player_pos.y/256) * base.mesh.height
  look_at(Vector3(0, position.y, 0))
