class Board
  attr_reader :positions, :pieces

  def initialize(size)
    @game_over = false
    @winner = false
    @size = size
    @pieces = ['X','O']
    @current_piece = nil
    @positions = []
    @size.times do
      array = []
      @size.times do
        array << " "
      end
      @positions << array
    end
  end

  def display
    line = "---+"
    puts "+" + (line*@size)
    @positions.each do |row|
      print "|"
      row.each do |x|
        print " #{x} |"
      end
      print "\n+" + (line*@size) + "\n"
    end
  end

  def get_starting_piece
    puts "Player 1 goes first."
    puts "Do you want to be x or o?"
    choice = gets.chomp.downcase
    choice == "x" ? @current_piece = @pieces[0] : @current_piece = @pieces[1]
  end

  def change_piece
    @current_piece == @pieces[0] ? @current_piece = @pieces[1] : @current_piece = @pieces[0]
  end

  def get_coordinates
    puts "Select a row:"
    x = gets.chomp.to_i - 1
    puts "Select a column:"
    y = gets.chomp.to_i - 1
    return [x,y]
  end

  def take_turn
    coords = get_coordinates
    @positions[coords[0]][coords[1]] = @current_piece
    display
    #check for wins and shit here
    winner if horizontal_win?
    winner if vertical_win?
    winner if diagonal_lr_win?
    winner if diagonal_rl_win?
    stalemate if full? && @winner == false

    unless @game_over == true
      change_piece
      take_turn
    end
  end

  def winner
    puts "#{@current_piece} wins! Game over."
    @game_over = true
    @winner = true
  end

  def stalemate
    puts "It's a tie! Game over."
    @game_over = true
  end

  #this is a clever but probably stupid way to do this.
  #i basically turn the row into a string, and compare it to a stringified version of the current piece * 3
  #i had a cool one line way of doing this but it only worked for 3x3 grids. this is the best i got right now
  def horizontal_win?
    @positions.each do |row|
      string = row.join
      return true if string.include?(@current_piece*3)
    end
    return false
  end

  #here i create a blank string and add the 0th element of each row, then the 1st etc.
  #i check if that string contains XXX or OOO
  def vertical_win?
    index = 0
    @size.times do
      string = ""
      @positions.each do |row|
        string << row[index]
      end
      puts string
      return true if string.include?(@current_piece*3)
      index += 1
    end
    return false
  end

  def diagonal_lr_win?
    y_index = 0
    (@size-2).times do
      x_index = 0
      (@size-2).times do
        string = ""
        string << @positions[y_index][x_index]
        string << @positions[y_index + 1][x_index + 1]
        string << @positions[y_index + 2][x_index + 2]
        return true if string.include?(@current_piece*3)
        x_index += 1
      end
      y_index += 1
    end
    return false
  end

  def diagonal_rl_win?
    y_index = 0
    (@size-2).times do
      x_index = 2
      (@size-2).times do
        string = ""
        string << @positions[y_index][x_index]
        string << @positions[y_index + 1][x_index - 1]
        string << @positions[y_index + 2][x_index - 2]
        return true if string.include?(@current_piece*3)
        x_index += 1
      end
      y_index += 1
    end
    return false
  end

  def full?
    all_positions = @positions.flatten
    puts all_positions.inspect
    all_positions.include?(" ") ? false : true
  end

  def empty?
    array = []
    (@size ** 2).times do
      array << " "
    end
    @positions.flatten == array ? true : false
  end
end


b = Board.new(3)
b.display
b.get_starting_piece
b.take_turn
