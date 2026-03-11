extends Control



func _on_button_pressed() -> void:
	UiSoundManager.play_select()
	get_tree().change_scene_to_file("res://scene/menu.tscn")
