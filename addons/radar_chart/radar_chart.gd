tool
extends Control

export(PoolStringArray) var sides setget update_sides
export(Font) var font setget update_font
export(int) var horizontal_padding = 0 setget update_horizontal_padding
export(int) var vertical_padding = 0 setget update_vertical_padding
export(int) var outline_thickness = 0 setget update_outline_thickness
const piover2 = 1.57079632679
var origin = Vector2()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	origin = Vector2(rect_size.x / 2, rect_size.y / 2)
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
		print("Radar Chart requires at least 3 sides to draw.")
		return
	origin = Vector2(rect_size.x / 2, rect_size.y / 2)
	var font_padding = font.get_height()
	var radius = 0
	# we use a font_padding to make our circle smaller so we have room for the text
	if rect_size.x > rect_size.y:
		radius = (rect_size.y - font_padding * 4) / 2
	else:
		radius = (rect_size.x - font_padding * 4 ) / 2
	var points = PoolVector2Array()
	var outline_points = PoolVector2Array()
	#draw_circle(origin, radius + font_padding, Color(0, 0, 0, 1))
	#draw_circle(origin, radius, Color(0.5, 0.5, 0.5, 1))
	for i in range(sides.size()):
		points.push_back(get_location_of_index(radius, i))
		outline_points.push_back(get_location_of_index(radius + outline_thickness, i))
		# draw the text for this axis
		var text_offset = font.get_string_size(sides[i])
		var text_point = get_location_of_index(radius,
											   i,
											   font_padding + vertical_padding,
											   font_padding + horizontal_padding)
		text_point = Vector2(text_point.x - text_offset.x / 2, text_point.y + text_offset.y / 4)
		draw_string(font, text_point, sides[i])
	# draw our polygon
	draw_polygon(outline_points, PoolColorArray([Color(0, 0, 0)]))
	draw_polygon(points, PoolColorArray())
	
	

	
	
func get_location_of_index(radius, index, vertical_padding = 0, horizontal_padding = 0):
	var angle = 2.0 * PI / sides.size()
	# x = intial x + radius * cos(angle in radians)
	# y = intial y + radius * sin(angle in radians)
	# we subtract piover2 here because we want
	# the first point at the top of the circle
	var x = origin.x + (radius + horizontal_padding) * cos(angle * index - piover2)
	var y = origin.y + (radius + vertical_padding) * sin(angle * index - piover2)
	return Vector2(x,y)
	
func update_horizontal_padding(value):
	horizontal_padding = value
	update()
	
func update_vertical_padding(value):
	vertical_padding = value
	update()	
	
func update_outline_thickness(value):
	outline_thickness = value
	update()
	
func update_font(value):
	font = value
	update()
	
func update_sides(value):
	sides = value
	update()
	
func set_position(value):
	rect_position = value
	update()