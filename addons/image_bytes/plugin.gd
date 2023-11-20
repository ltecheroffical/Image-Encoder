@tool
extends EditorPlugin


func _enter_tree() -> void:
	add_custom_type("ImageBytes", "RefCounted", 
		preload("res://addons/image_bytes/bytes_to_image.gd"), 
		preload("res://addons/image_bytes/icon.svg"))


func _exit_tree() -> void:
	remove_custom_type("ImageBytes")
