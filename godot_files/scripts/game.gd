extends Control


@onready var animation_player: AnimationPlayer = %AnimationPlayer


#shows the current player. also the starting point of the game
var current_player = "X"

#this shows who is the winner, O or X
var winner = ""

#this is the state of the board which stores the game state meaning where is O and where is X
var board_state = [
	["","",""],
	["","",""],
	["","",""],
]

#this is for determining the draw time
var moves: int



#this stores all 9 buttons and lets it access their properties
var button_position = []

#this is a variable for the AI, It will handle two functions, one for when the player is first other for when the computer if first
var AI


##########################################################################################################3333
func _ready() -> void:
	#which one is first
	AI = Callable(self,"ai_player_is_first")
	
	
	
	for row_node in $VBoxContainer.get_children():
		button_position.append(row_node.get_children())
	
	#getting all the buttons in a single variable
	for button in get_tree().get_nodes_in_group("grid_buttons"):
		button.pressed.connect(_on_button_pressed.bind(button))


#############################################################################################
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
		#$WaitTime.start()
		#await $WaitTime.timeout
		#AI.call()
		#check_winner()
		#
		#switch_player()
		#prints the variable assigned in the win functions
		print(winner)
###############################################################################################3


#handling the player switching
func switch_player():
	if current_player == "O":
		current_player = "X"
	else:
		current_player = "O"

###############################################################################################3



#handling the draw
func draw():
	moves +=1
	if moves ==9:
		print("game over")
		stop1()

func stop1():
	animation_player.play("stop_animation")


#########################################################################################################33

#this checks for the winner
func check_winner():
	
	
	row_win()
	col_win()
	diag_win()

######################


#check for rows
func row_win():
	for i in range(3):
		if board_state[i][0] != "" and board_state[i][0] == board_state[i][1] and board_state[i][1] == board_state[i][2]:
			print(String(board_state[i][0]) + " wins in rows")
			#the variable for who won the round
			winner = board_state[i][0]
			stop()



#########################
#check for columns
func col_win():
	for i in range(3):
		if board_state[0][i] != "" and board_state[0][i] == board_state[1][i] and board_state[1][i] == board_state[2][i]:
			print(String(board_state[0][i]) + " wins in columns")
			#the variable for who won the round
			winner = board_state[0][i]
			stop()


###########################

#check for diagonals
func diag_win():
	if board_state[0][0] != "" and board_state[0][0] == board_state[1][1] and board_state[1][1] == board_state[2][2]:
		print(board_state[0][0] + " wins in diagonals")
		#the variable for who won the round
		winner = board_state[0][0]
		stop()
		
	if board_state[0][2] != "" and board_state[0][2] == board_state[1][1] and board_state[1][1] == board_state[2][0]:
		print(board_state[0][2] + " wins in other diagonals")
		#the variable for who won the round
		winner = board_state[0][2]
		stop()


##################
func stop():
	animation_player.play("win_animation")




#########################################################################################################33










#one ui control
func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()



func ai_player_is_first():
	pass







func ai_comp_is_first():
	pass
	
