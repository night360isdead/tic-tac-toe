extends Control




func _on_button_pressed() -> void:
	UiSoundManager.play_select()
	get_tree().change_scene_to_file("res://scene/game_1.tscn")

func _on_button_2_pressed() -> void:
	UiSoundManager.play_select()
	get_tree().change_scene_to_file("res://scene/credits.tscn")


func _on_button_3_pressed() -> void:
	UiSoundManager.play_select()
	get_tree().quit()
