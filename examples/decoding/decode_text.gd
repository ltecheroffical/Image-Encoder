extends Control


@onready var input_image: TextureRect = %ResultImage
@onready var output_text: TextEdit = %InputText



func _on_decode_pressed():
	var text_bytes: PackedByteArray = []
	text_bytes = ImageBytes.decode_data(input_image.texture.get_image())
	
	output_text.text = text_bytes.get_string_from_utf8()


func _on_image_dialog_file_selected(path: String) -> void:
	var image := Image.load_from_file(path)
	
	input_image.texture = ImageTexture.create_from_image(image)
