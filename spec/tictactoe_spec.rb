require_relative '../tictactoe.rb'

RSpec.describe GameBoard do
  describe "#winning stuff" do
    it "checks if top row of Xs is a win" do
      g = GameBoard.new
      g.char = "X"
      g.one = "X"
      g.two = "X"
      g.three = "X"
      expect(g.winner?).to eql(true)
    end
  end
end
