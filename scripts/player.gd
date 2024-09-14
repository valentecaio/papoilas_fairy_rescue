extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var animated_sprite_2d_2: AnimatedSprite2D = $AnimatedSprite2D2

func _physics_process(delta):
  # gravity.
  if not is_on_floor():
    velocity.y += gravity * delta

  # jump
  if Input.is_action_just_pressed("jump") and is_on_floor():
    velocity.y = JUMP_VELOCITY

  # 0 idle, 1 moving right, -1 moving left
  var direction = Input.get_axis("move_left", "move_right")

  # move left/right (and flip animation)
  if direction:
    animated_sprite_2d.flip_h = direction < 0
    animated_sprite_2d_2.flip_h = direction < 0
    velocity.x = direction * SPEED
  else:
    velocity.x = move_toward(velocity.x, 0, SPEED)

  # animation
  if is_on_floor():
    if direction == 0:
      animated_sprite_2d.play("idle")
      animated_sprite_2d_2.play("idle")
    else:
      animated_sprite_2d.play("run")
      animated_sprite_2d_2.play("run")
  else:
    animated_sprite_2d.play("jump")
    animated_sprite_2d_2.play("jump")

  move_and_slide()

  if (position.x > 138):
    position.x -= 256
    
  if (position.x < -138):
    position.x += 256
