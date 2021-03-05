class KnightTravails
  def initialize(start, stop)
    @start = start
    @stop = stop
    @board = make_board
    @all_moves_h = all_moves
    @path_map = {}
  end

  def knight_moves
    grade_board
    path = @path_map[@stop]
    puts "You made it in #{path} moves! Here's your path:"
    path.each { |move| p move }
  end

  private

  def grade_board(current = @start, score = 0, path = [])
    return if get_score(current) < score

    change_score(current, score)
    p = path.clone
    p << current
    @path_map[current] = p
    get_moves(current).each { |move| grade_board(move, score + 1, p) }
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
    @all_moves_h.keys.select { |e| e[0..1] == sub_name }.flatten
  end

  def valid_moves(start)
    @board.select { |stop| valid_move?(start, stop) }
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
    infinity = 1 / 0.0
    moves = @board.map { |start| valid_moves(start) }
    board_hash = Hash[@board.zip moves]
    board_hash.transform_keys { |k| k + [infinity] }
  end
end