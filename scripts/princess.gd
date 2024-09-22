extends CharacterBody2D


@export var speed = 130.0
@export var jump_velocity = -280.0
var climbing := false

@onready var area_2d:   Area2D = $Area2D
@onready var area_2d_2: Area2D = $Area2D2
@onready var collision_shape_2d:   CollisionShape2D = $CollisionShape2D
@onready var collision_shape_2d_2: CollisionShape2D = $CollisionShape2D2
@onready var animated_sprite_2d:   AnimatedSprite2D = $AnimatedSprite2D
@onready var animated_sprite_2d_2: AnimatedSprite2D = $AnimatedSprite2D2

var areas: Array[Area2D]
var animated_sprites: Array[AnimatedSprite2D]


func _ready():
    areas = [area_2d, area_2d_2]
    animated_sprites = [animated_sprite_2d, animated_sprite_2d_2]
    animated_sprite_2d_2.position.x = Global.stage_w
    collision_shape_2d_2.position.x = Global.stage_w
    area_2d_2.position.x = Global.stage_w
    flip_sprites(true)


func _physics_process(delta):
    var dir = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).normalized()
    if climbing:
        process_climb(delta, dir)
    else:
        process_default(delta, dir)

    # update global player position for enemies to follow
    move_and_slide()
    Global.player_position = position


func process_default(delta, dir):
    # gravity
    if not is_on_floor():
        velocity += 0.85 * get_gravity() * delta

    # jump
    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = jump_velocity

    # move left/right (and flip animation)
    # 0 idle, 1 moving right, -1 moving left
    if dir.x:
        flip_sprites(dir.x < 0)
        velocity.x = dir.x * speed
    else:
        velocity.x = move_toward(velocity.x, 0, speed)

    # animation
    if is_on_floor() and dir.x:
        play("run")
    elif is_on_floor() and !dir.x:
        play("idle")
    else:
        play("jump")

    # wrap around the stage
    var stage_w = Global.stage_w
    var threshold = 10 + stage_w/2.0
    if (position.x > threshold):
        position.x -= stage_w
    if (position.x < -threshold):
        position.x += stage_w

    # go to climbing state
    # !dir.x avoids blinking states when pressing diagonally
    if is_on_ladder() and dir.y and !dir.x:
        climbing = true
        velocity = Vector2.ZERO


func process_climb(_delta, dir):
    # nullify horizontal movement
    velocity.x = 0

    # move up/down
    velocity.y = dir.y * speed/2

    # animation
    if dir.y < 0:
        play("climb")
    elif dir.y > 0:
        play_backwards("climb")
    else:
        pause_animation()

    # go to default state
    if !is_on_ladder() or dir.x or Input.is_action_pressed("jump"):
        climbing = false
        velocity = Vector2.ZERO



### AUXILIARY FUNCTIONS ###

func play(animation):
    for sprite in animated_sprites:
        sprite.play(animation)

func play_backwards(animation):
    for sprite in animated_sprites:
        sprite.play_backwards(animation)

func pause_animation():
    for sprite in animated_sprites:
        sprite.pause()

func flip_sprites(flip):
    for sprite in animated_sprites:
        sprite.flip_h = flip

func is_on_ladder():
    for area in areas:
        if area.get_overlapping_bodies():
            return true
    return false


### CALLED BY OTHER SCRIPTS ###

# bounce when jumping on an enemy
func bounce():
    velocity.y = 0.75 * jump_velocity
    Global.player_kills += 1

func die():
    # play("death")
    climbing = false
    velocity = Vector2.ZERO
