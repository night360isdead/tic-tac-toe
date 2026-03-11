extends Node


@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var audio_stream_player_3: AudioStreamPlayer = $AudioStreamPlayer3
@onready var audio_stream_player_2: AudioStreamPlayer = $AudioStreamPlayer2
@onready var game_over: AudioStreamPlayer = $game_over


func play_over():
	game_over.play()

func play_select():
	audio_stream_player_2.play()


func play_click():
	audio_stream_player_3.play()


func play_hover():
	audio_stream_player.play()
