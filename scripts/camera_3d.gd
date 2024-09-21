extends Camera3D

@onready var base = $"../Tower/StageMid"
@onready var stage_2d = $"../Tower/Stage2DSubViewport/Stage2D"
@onready var wall: MeshInstance3D = $"../Tower/Wall"
var material: ShaderMaterial
var left_plane_material: ShaderMaterial

@onready var wall_left_plane: MeshInstance3D = $"../WallLeftPlane"
@export var wall_radius := 26.5
@export var uv_margin = 0.05

@export var distance := 15


func _ready():
    stage_2d.player_position_changed.connect(_on_stage_2d_player_position_changed)
    material = wall.mesh.surface_get_material(0)
    left_plane_material = wall_left_plane.mesh.surface_get_material(0)
    material.set_shader_parameter("uv_margin", uv_margin)

func _physics_process(delta: float) -> void:
    var dir = Input.get_axis("turn_left", "turn_right")
    base.rotate(Vector3(0,1,0), deg_to_rad(-dir*delta*50))


func _on_stage_2d_player_position_changed(cur_player_pos):
    var angle = deg_to_rad(cur_player_pos.x * 360.0 / 1024)
    var uv_center = angle / (2 * PI)
    if (uv_center < 0.00):
        uv_center += 1.0
    material.set_shader_parameter("current_center_uv", uv_center)
    
    #print(cur_player_pos, " ", rad_to_deg(angle))
    position.x = distance * sin(angle)
    position.z = distance * cos(angle)
    position.y = (1 - cur_player_pos.y/256) * base.mesh.height + 6
    look_at(Vector3(0, position.y, 0))
    
    var left_plane_angle = angle - uv_margin * (2*PI)
    wall_left_plane.position.x = wall_radius * sin(left_plane_angle) 
    wall_left_plane.position.z = wall_radius * cos(left_plane_angle) 
    wall_left_plane.rotation.y = left_plane_angle
    wall_left_plane.rotation.z = -90.0
    left_plane_material.set_shader_parameter("uv_x", uv_center - uv_margin)
