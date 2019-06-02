tool
extends Control

export(Dictionary) var sides = {"Strength": 2, "Intelligence": 3, "Dextarity": 1} setget update_sides
export(int) var outline_thickness = 0 setget update_outline_thickness
export(Color) var outline_color = Color(0, 0, 0) setget update_outline_color
export(Color) var background_color = Color(255, 255, 255) setget update_background_color
const piover2 = PI/2

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	connect("resized", self, "resized")
	update()
	
func resized():
	# update the origin location
	# redraw
	update()

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	pass

func _draw():
	if (sides.size() < 3):
		print("Radar chart requires at least 3 sides to draw.")
		return
	var origin = Vector2(rect_size.x / 2, rect_size.y / 2)
	var radius = origin.y if rect_size.x > rect_size.y else origin.x
	var points = PoolVector2Array()
	var outline_points = PoolVector2Array()
	draw_circle(origin, radius, Color(0.5, 0.5, 0.5, 1))
	for i in range(sides.size()):
		points.push_back(get_location_of_index(radius - outline_thickness, i, origin))
		outline_points.push_back(get_location_of_index(radius, i, origin))
	# draw our polygon
	draw_polygon(outline_points, PoolColorArray([outline_color]))
	draw_polygon(points, PoolColorArray([background_color]))
	
func get_location_of_index(radius, index, origin):
	var angle = 2.0 * PI / sides.size()
	# x = intial x + radius * cos(angle in radians)
	# y = intial y + radius * sin(angle in radians)
	# we subtract piover2 here because we want
	# the first point at the top of the circle
	var x = origin.x + radius * cos(angle * index - piover2)
	var y = origin.y + radius * sin(angle * index - piover2)
	return Vector2(x,y)
	
func update_outline_thickness(value):
	outline_thickness = value
	update()
	
func update_outline_color(value):
	outline_color = value
	update()

func update_background_color(value):
	background_color = value
	update()
	
func update_sides(value):
	sides = value
	update()
	
func set_position(value):
	rect_position = value
	update()
	