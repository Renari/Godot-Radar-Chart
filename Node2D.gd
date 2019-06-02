extends Node2D

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
    update()

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass

func _draw():
    draw_circle(Vector2(), 10, Color(0, 0.5, 1, 1))