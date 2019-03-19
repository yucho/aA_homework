class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @p1_name = name1
    @p2_name = name2
    @p1_cup_idx = 13
    @p2_cup_idx = 6
    @cups = Array.new(14) { place_stones }
    cups[@p1_cup_idx] = []
    cups[@p2_cup_idx] = []
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    Array.new(4, :stone)
  end

  def valid_move?(start_pos)
    raise 'Invalid starting cup' if start_pos >= cups.length

    raise 'Starting cup is empty' if cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    num_stones = cups[start_pos].length
    cups[start_pos] = []

    is_p2 = (current_player_name == @p2_name)
    @players_cup   = is_p2 ? @p1_cup_idx : @p2_cup_idx
    @opponents_cup = is_p2 ? @p2_cup_idx : @p1_cup_idx

    num_skip = 1
    cup_idx = 0
    num_stones.times do |idx|
      cup_idx = (start_pos + idx + num_skip) % cups.length
      if @opponents_cup == cup_idx
        num_skip += 1
        cup_idx = (cup_idx + 1) % cups.length
      end
      @last_cup = cups[cup_idx].dup
      cups[cup_idx] << :stone
    end

    render
    next_turn(cup_idx)
  end

  def next_turn(ending_cup_idx)
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    return :prompt if ending_cup_idx == @players_cup

    return :switch if @last_cup.empty?

    ending_cup_idx
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    @cups[0..5].all?(&:empty?) || @cups[7..12].all?(&:empty?)
  end

  def winner
    case @cups[@p1_cup_idx].length <=> @cups[@p2_cup_idx].length
    when 0
      :draw
    when 1
      @p2_name
    when -1
      @p1_name
    end
  end
end
