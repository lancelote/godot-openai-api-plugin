@tool
extends EditorPlugin


func _enter_tree():
	add_autoload_singleton("OpenAI", "res://addons/godot_openai_api_plugin/openai.gd")


func _exit_tree():
	remove_autoload_singleton("OpenAI")
