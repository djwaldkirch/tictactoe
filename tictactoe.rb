class Board
  attr_reader :positions, :pieces

  def initialize(size)
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
    if horizontal_win?
      puts "congrats"
    end

    if vertical_win?
      puts "congrats"
    end


    change_piece
    take_turn
  end

  #this is a clever but probably stupid way to do this.
  #i basically turn the row into a string, and compare it to a stringified version of the current piece * 3
  #i had a cool one line way of doing this but it only worked for 3x3 grids. this is the best i got right now
  def horizontal_win?
    @positions.each do |row|
      string = row.join
      if string.include?(@current_piece*3)
        return true
      end
    end
    return false
  end

  def vertical_win?
    index = 0
    @positions.each do |row|
      new_array = []
      new_array << row[index]
      string = new_array.join
      if string.include?(@current_piece*3)
        return true
      else
        index += 1
      end
    end
    return false
  end

end


b = Board.new(3)
b.display
b.get_starting_piece
b.take_turn
