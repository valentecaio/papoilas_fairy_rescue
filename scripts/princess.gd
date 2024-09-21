extends CharacterBody2D


@export var speed = 130.0
@export var jump_velocity = -280.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite_2d:     AnimatedSprite2D = $AnimatedSprite2D
@onready var animated_sprite_2d_2: AnimatedSprite2D = $AnimatedSprite2D2
var animated_sprites: Array[AnimatedSprite2D]


func _ready():
    animated_sprites = [animated_sprite_2d, animated_sprite_2d_2]


func _physics_process(delta):
    # gravity
    if not is_on_floor():
        velocity.y += 0.85 * gravity * delta

    # jump
    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = jump_velocity

    # 0 idle, 1 moving right, -1 moving left
    var direction = Input.get_axis("move_left", "move_right")

    # move left/right (and flip animation)
    if direction:
        for sprite in animated_sprites:
            sprite.flip_h = direction < 0
        velocity.x = direction * speed
    else:
        velocity.x = move_toward(velocity.x, 0, speed)

    # animation
    if is_on_floor():
        if direction:
            for sprite in animated_sprites: sprite.play("run")
        else:
            for sprite in animated_sprites: sprite.play("idle")
    else:
        for sprite in animated_sprites: sprite.play("jump")

    move_and_slide()
    Global.player_position = position

    var stage_w = 1024
    var threshold = 10 + stage_w/2.0
    if (position.x > threshold):
        position.x -= stage_w

    if (position.x < -threshold):
        position.x += stage_w

# bounce when jumping on an enemy
func bounce():
    velocity.y = 0.75 * jump_velocity
