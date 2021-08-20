tool
extends Node2D

# The variables "_sprite" and "_colors" are created using
# https://github.com/hiulit/aseprite-to-godot-variables

export(Array, Array, int) var sprite = _sprite setget _set_sprite
export(PoolColorArray) var colors = _colors setget _set_colors
export(Vector2) var repeat = Vector2.ONE setget _set_repeat
export(int) var pixel_size = 1 setget _set_pixel_size
export(Vector2) var offset = Vector2.ZERO setget _set_offset

# The numbers of the "_sprite" array are the indices of the "_colors" array.
# The "_sprite" array can have "null" values as well. Those will be completly transparent pixels.
var _sprite = [
	[0,0,0,0,0,0,0,1,1,0,0,],
	[0,0,0,0,1,1,0,1,1,1,0,],
	[0,0,1,0,1,1,0,1,1,1,0,],
	[0,1,1,0,0,1,0,0,0,0,0,],
	[1,1,1,1,0,0,0,0,0,0,0,],
	[0,1,1,1,0,0,0,1,1,0,0,],
	[0,0,1,0,0,1,1,1,1,0,0,],
	[0,1,1,1,1,1,1,0,0,1,1,],
	[1,1,1,1,1,1,1,0,1,1,1,],
]
var _colors = PoolColorArray([
	Color(1.0,0.63,0.0,1.0),
	Color(0.67,0.32,0.21,1.0),
])


func _draw():
	for i in repeat.x:
		for j in repeat.y:
			for k in sprite.size():
				# To get the "x" value, we take the first row of the sprite to determine its width.
				var x = i * pixel_size * sprite[0].size()
				var y = k * pixel_size + (j * sprite.size() * pixel_size)
				for c in sprite[k]:
					if c == null:
						x += pixel_size
						continue
					draw_rect(
						Rect2(
							Vector2(offset.x + x, offset.y + y),
							Vector2.ONE * pixel_size
						),
						colors[c]
					)
					x += pixel_size


func _set_offset(new_value):
	if new_value != offset:
		offset = new_value
		update()


func _set_sprite(new_value):
	if new_value != sprite:
		if new_value.size() == 0:
			new_value = _sprite
		sprite = new_value
		update()


func _set_repeat(new_value):
	if new_value != repeat:
		if new_value.x <= 0 or new_value.y <= 0:
			if new_value.x <= 0:
				repeat.x = 1
			if new_value.y <= 0:
				repeat.y = 1
		else:
			repeat = new_value
		update()


func _set_colors(new_value):
	if new_value != colors:
		if new_value.size() == 0:
			new_value = _colors
		colors = new_value
		update()


func _set_pixel_size(new_value):
	if new_value != pixel_size:
		if new_value <= 0:
			new_value = 1
		pixel_size = new_value
		update()
