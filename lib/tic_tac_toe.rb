WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

#### Turn
def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index, current_player(board))
    move(board, index)
    display_board(board)
  else
    turn(board)
  end
end


##### Player
def turn_count(board)
  counter = 0
  board.each do |square|
    if square == "X" || square == "O"
      counter +=1
    end
  end
  counter
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

#### Stop Conditions

def won?(board)
  WIN_COMBINATIONS.find do |combo|
    combo.all? {|i| board[i] == "X"} || combo.all? {|i| board[i] == "O"}
  end
end

def full?(board)
  board.all? { |index| index == "X" || index == "O" }
end

def draw?(board)
  if full?(board) && !won?(board)
    true
  elsif !full?(board) && !won?(board) || won?(board)
    false
  end
end

def over?(board)
  won?(board) || draw?(board)
end

def winner(board)
  if won?(board)
    i = won?(board)[0]
    board[i]
  else
    nil
  end
end

def play(board)
  until over?(board)
    turn(board)
  end
  if draw?(board)
    puts "Cat's Game!"
  else
    puts "Congratulations #{winner(board)}!"
  end
end
