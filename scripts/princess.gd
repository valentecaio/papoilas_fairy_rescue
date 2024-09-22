extends CharacterBody2D


@export var speed = 130.0
@export var jump_velocity = -280.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite_2d:   AnimatedSprite2D = $AnimatedSprite2D
@onready var animated_sprite_2d_2: AnimatedSprite2D = $AnimatedSprite2D2
var animated_sprites: Array[AnimatedSprite2D]

@onready var collision_shape_2d_2: CollisionShape2D = $CollisionShape2D2


func _ready():
    animated_sprites = [animated_sprite_2d, animated_sprite_2d_2]
    animated_sprite_2d_2.position.x = Global.stage_w
    collision_shape_2d_2.position.x = Global.stage_w
    for sprite in animated_sprites: sprite.flip_h = true


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
    move_and_slide()

    # animation
    if is_on_floor():
        if direction:
            for sprite in animated_sprites: sprite.play("run")
        else:
            for sprite in animated_sprites: sprite.play("idle")
    else:
        for sprite in animated_sprites: sprite.play("jump")


    var stage_w = Global.stage_w
    var threshold = 10 + stage_w/2.0
    if (position.x > threshold):
        position.x -= stage_w
    if (position.x < -threshold):
        position.x += stage_w

    # update global player position for enemies to follow
    Global.player_position = position


# bounce when jumping on an enemy
func bounce():
    velocity.y = 0.75 * jump_velocity
