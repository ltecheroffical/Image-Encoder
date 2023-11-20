extends Control


@onready var input_image: TextureRect = %ResultImage
@onready var output_text: TextEdit = %InputText



func _on_decode_pressed():
	var image_bytes := ImageBytes.decode_data(input_image.texture.get_image())
	var file_bytes = Marshalls.raw_to_base64(image_bytes)
	
	output_text.text = file_bytes


func _on_image_dialog_file_selected(path: String) -> void:
	var image := Image.load_from_file(path)
	
	input_image.texture = ImageTexture.create_from_image(image)
