extends Camera3D

@onready var base = $"../Tower/Base"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
  # 0 idle, 1 moving right, -1 moving left
  var dir = Input.get_axis("turn_left", "turn_right")

  if dir:
    base.rotate(Vector3(0,1,0), deg_to_rad(-dir*delta*50))
