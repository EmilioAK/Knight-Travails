require 'pp'

class KnightTravails
  attr_accessor :all_moves_h
 
  def initialize(start, stop)
    @start = start
    @stop = stop
    @board = make_board
    @all_moves_h = all_moves
  end

  def least_moves_to_stop
    pp grade_board
    pp get_score(@stop)
  end

  def grade_board(current = @start, score = 0, path = [])
    # Path doesn't currently get the shortest path
    if get_score(current) < score
      return
    else
      change_score(current, score)
      get_moves(current).each {|move| grade_board(move, score + 1, path)}
    end
  end

  def get_moves(square)
    @all_moves_h[get_square(square)]
  end

  def change_score(square, new_score)
    curr_score = get_score(square)
    @all_moves_h[square + [new_score]] = @all_moves_h.delete(square + [curr_score])
  end

  def get_score(square)
    get_square(square)[-1]
  end

  def get_square(sub_name)
    @all_moves_h.keys.select {|e| e[0..1] == sub_name}.flatten
  end

  private

  def valid_moves(start)
    @board.select {|stop| valid_move?(start, stop)}
  end

  def valid_knight_movement?(start, stop)
    valid_y_movement = (start[0] - stop[0]).abs == 2 && (start[1] - stop[1]).abs == 1
    valid_x_movement = (start[1] - stop[1]).abs == 2 && (start[0] - stop[0]).abs == 1
    
    valid_y_movement || valid_x_movement
  end

  def valid_move?(start, stop)
    valid_knight_movement?(start, stop) && @board.include?(stop)
  end

  def make_board
    nums = (1..8).to_a

    nums.product(nums)
  end

  def all_moves
    infinity = 1/0.0
    moves = @board.map {|start| valid_moves(start)}
    board_hash = Hash[@board.zip moves]
    board_hash.transform_keys {|k| k + [infinity]}
  end
end

bajs = KnightTravails.new([4,4], [4,2])

pp bajs.grade_board