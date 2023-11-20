# Made by LTecher
# MIT LICENSE
#
# This script works without the plugin,
# Feel free to use in your own projects.

class_name ImageBytes
extends RefCounted
## A class to encode and decode bytes from and to images
## [br][br]
## Encode example:
## [codeblock]
## var random_data: PackedByteArray = []
## 
## # Generate 100 bytes of random data for demonstration purposes
## for _range in range(1, 1000):
##     random_data.append(randi_range(0, 255))
## 
## var output_image := ImageBytes.encode_data(random_data)
## [/codeblock]
## [color=yellow]WARNING: Modifying an image output from this class will corrupt the file stored in it.[/color]


## The color to ignore when decoding the image
const IGNORE_COLOR = Color.HOT_PINK


## Encode data into an image, this returns an image
## [br]
## Depending on the size of the data it may take hours to encode
## [br][br]
## [b][color=yellow]WARNING: DO NOT MODIFY THE OUTPUT OF THIS FUNCTION UNLESS YOU WANT TO MODIFY THE FILE[/color][/b]
static func encode_data(data_buffer: PackedByteArray, size_divisor: int = 128) -> Image:
	# Ensure the image size is calculated based on the specified divisor
	var pixels_per_unit := roundi(float(len(data_buffer)) / size_divisor)
	var output_image := Image.create(pixels_per_unit, pixels_per_unit, false, Image.FORMAT_RGB8)
	var file_index = 0

	for x in range(output_image.get_width()):
		for y in range(output_image.get_height()):
			var color_value : float

			# Check if the end of the data buffer is reached
			if ((file_index + 1) >= len(data_buffer)):
				output_image.set_pixel(x, y, IGNORE_COLOR)
				continue

			# Normalize the data value to the range [0, 1] for color representation
			color_value = float(data_buffer[file_index]) / 255
			output_image.set_pixel(x, y, Color(color_value, color_value, color_value))
			file_index += 1

	return output_image

## Decode data from an image
static func decode_data(image_data: Image) -> PackedByteArray:
	var decoded_file : PackedByteArray = []

	for x in range(image_data.get_width()):
		for y in range(image_data.get_height()):
			var color := image_data.get_pixel(x, y)

			# Check if the special color is encountered, indicating the end of data
			if color == IGNORE_COLOR:
				break

			# Reverse the normalization to obtain the original data value
			decoded_file.append(int(color.r * 255))

	return decoded_file
