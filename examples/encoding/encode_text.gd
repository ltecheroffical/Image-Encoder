extends Control


@onready var result_image: TextureRect = %ResultImage
@onready var input_text: TextEdit = %InputText
@onready var encode_divisor: SpinBox = %EncodeDivisor



func _on_encode_pressed():
	var text_bytes: PackedByteArray = []
	text_bytes = input_text.text.to_utf8_buffer()
	
	var image := ImageBytes.encode_data(text_bytes, int(encode_divisor.value))
	result_image.texture = ImageTexture.create_from_image(image)


func _on_image_dialog_file_selected(path: String) -> void:
	result_image.texture.get_image().save_png(path)
