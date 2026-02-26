extends Control


@onready var animation_player: AnimationPlayer = %AnimationPlayer



var current_player = "x"

var winner = ""


var board_state = [
	["","",""],
	["","",""],
	["","",""],
]


var moves: int



func _ready() -> void:
	
	
	#getting all the buttons in a single variable
	for button in $GridContainer.get_children():
		button.pressed.connect(_on_button_pressed.bind(button))


# main game loop

func _on_button_pressed(button) -> void:
	if button.text == "":
		
		var name_parts = String(button.name).split("_")
		var row = int(name_parts[1])
		var col = int(name_parts[2])
		
		board_state[row][col] = current_player
		
		button.text = current_player
		
		
		
		
		
		draw()
		
		check_winner()
		
		switch_player()
		
		print(winner)


#handling the draw
func draw():
	moves +=1
	if moves ==9:
		print("game over")
		stop1()




#check for rows
func row_win():
	for i in range(3):
		if board_state[i][0] != "" and board_state[i][0] == board_state[i][1] and board_state[i][1] == board_state[i][2]:
			print(String(board_state[i][0]) + " wins in rows")
			winner = board_state[i][0]
			stop()





#check for columns\
func col_win():
	for i in range(3):
		if board_state[0][i] != "" and board_state[0][i] == board_state[1][i] and board_state[1][i] == board_state[2][i]:
			print(String(board_state[0][i]) + " wins in columns")
			winner = board_state[0][i]
			stop()




#check for diagonals
func diag_win():
	if board_state[0][0] != "" and board_state[0][0] == board_state[1][1] and board_state[1][1] == board_state[2][2]:
		print(board_state[0][0] + " wins in diagonals")
		winner = board_state[0][0]
		stop()
		
	if board_state[0][2] != "" and board_state[0][2] == board_state[1][1] and board_state[1][1] == board_state[2][0]:
		print(board_state[0][2] + " wins in other diagonals")
		winner = board_state[0][2]
		stop()




	

#this checks for the winner
func check_winner():
	
	
	row_win()
	col_win()
	diag_win()





#handling the player switching
func switch_player():
	if current_player == "o":
		current_player = "x"
	else:
		current_player = "o"




func stop():
	animation_player.play("win_animation")

func stop1():
	animation_player.play("stop_animation")



#one ui control
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
