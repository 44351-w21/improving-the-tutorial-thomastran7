extends Area2D

signal hit

export var speed = 400
var screen_size 
onready var stats = Stats
onready var hurtbox  = $Hurtbox

# Called when the node enters the scene tree for the first time.
func _ready():
	stats.connect("no_health", self, "queue_free")
	screen_size = get_viewport_rect().size
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()
# up, down, left, right arrow movement keys
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
# WASD movement keys
	if Input.is_action_pressed("Right"):
		velocity.x += 1
	if Input.is_action_pressed("Left"):
		velocity.x -= 1
	if Input.is_action_pressed("Down"):
		velocity.y += 1
	if Input.is_action_pressed("Up"):
		velocity.y -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		#AnimitedSprite gets the child node that is called AnimatedSprite
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = 'walk'
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y >= 0:
		$AnimatedSprite.animation = 'down'
		$AnimatedSprite.flip_v = velocity.y < 0
	elif velocity.y <= 0:
		$AnimatedSprite.animation = 'up'
		$AnimatedSprite.flip_v = velocity.y > 0

#func _on_Player_body_entered(body):
	#hide()
	#emit_signal('hit')
	#$CollisionShape2D.set_deferred("disabled", true)
	
func _on_Hurtbox_area_entered(area):
	stats.health -= area.damage
	print(stats.health)

func _on_Stats_no_health():	
	hide()
	#emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
