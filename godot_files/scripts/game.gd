extends Control


@onready var animation_player: AnimationPlayer = %AnimationPlayer


#shows the current player. also the starting point of the game
var current_player = "X"


#the player and the ai symbol

var human_player = "X"
var ai_player = "O"





#this shows who is the winner, O or X
var winner = ""

#this is the state of the board which stores the game state meaning where is O and where is X
var board_state = [
	["","",""],
	["","",""],
	["","",""],
]

#this is for determining the draw time
var moves: int = 0



#this stores all 9 buttons and lets it access their properties
var button_position = []




##########################################################################################################3333
func _ready() -> void:
	
	
	
	
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
		if moves == 9:
			return
		check_winner()
		if winner != "":
			return
		
		switch_player()
		best_move()
		
		draw()
	
		check_winner()
		if winner != "":
			return
		switch_player()
		
		
		
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
	return

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
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()









#################################

#this is for the minimax algorithm simulation
func get_winner():
	
	#detecting the rows
	for i in range(3):
		if board_state[i][0] != "" and board_state[i][0] == board_state[i][1] and board_state[i][1] == board_state[i][2]:
			return board_state[i][0]

	# detecting the columns
	for i in range(3):
		if board_state[0][i] != "" and board_state[0][i] == board_state[1][i] and board_state[1][i] == board_state[2][i]:
			return board_state[0][i]

	# detecting the diagonals
	if board_state[0][0] != "" and board_state[0][0] == board_state[1][1] and board_state[1][1] == board_state[2][2]:
		return board_state[0][0]

	if board_state[0][2] != "" and board_state[0][2] == board_state[1][1] and board_state[1][1] == board_state[2][0]:
		return board_state[0][2]

	return ""


#this will check if the board is full or not.


func is_board_full():
	for i in range (3):
		for j in range(3):
			if board_state[i][j] == "":
				return false
	return true





#calculated the best possible move
func best_move():
	var best_score = -INF
	var move 
	for i in range(3):
		for j in range(3):
			if board_state[i][j] == "":
				board_state[i][j] = ai_player
				var score = minimax(false)
				board_state[i][j] = ""
				if score > best_score:
					best_score = score
					move = Vector2i (i,j)
	
	board_state[move.x][move.y] = ai_player
	button_position[move.x][move.y].text = ai_player




#############################################################################333
#minimax algorithm
func minimax (is_maximizing):
	#stops the recursion and returns the outcome for the particular spot
	var result = get_winner()
	if result == ai_player:
		return 1
	if result == human_player:
		return -1
	if is_board_full():
		return 0
	
	if is_maximizing:
		var best_score = -INF
		for i in range (3):
			for j in range (3):
				if board_state[i][j] == "":
					board_state[i][j] = ai_player
					var score = minimax(false)
					board_state[i][j] = ""
					best_score = max(score,best_score)
		return best_score
	else:
		var best_score = INF
		for i in range (3):
			for j in range (3):
				if board_state[i][j] == "":
					board_state[i][j] = human_player
					var score = minimax(true)
					board_state[i][j] = ""
					best_score = min(score,best_score)
		return best_score

	
	
	
