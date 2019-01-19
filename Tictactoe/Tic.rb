require 'json'

# Tictactoe on Ruby
class Tietactoe
  def initialize(auto = false)
    @item = {}
    @amount = []
    automatic(auto)
  end

  def automatic(auto)
    if auto != 'enable'
      handle
    elsif auto == 'enable'
      loop do
        @auto = true
        robot(0, true).robot(0, false)
        puts "#{display}\n"
        finish
        reset
      end
    end
  end

  def clean
    @amount = []
    @item = {}
  end

  def warning(text)
    abort(text) unless @auto
    puts text if @auto
    clean if @auto
  end

  def handle
    loop do
      puts 'Please Enter (0-8):'
      input = STDIN.gets.chomp
      handle unless input =~ /^[0-8]$/
      handle if @item[input.to_i]
      add_item(input.to_i).launch
      break if @item.length == 9
    end
  end

  def launch
    robot
    puts "#{display}\n"
    finish
    reset
  end

  def display
    <<-DISPLAY
    -------------
    |#{conetent(0)}|#{conetent(1)}|#{conetent(2)}|
    -------------
    |#{conetent(3)}|#{conetent(4)}|#{conetent(5)}|
    -------------
    |#{conetent(6)}|#{conetent(7)}|#{conetent(8)}|
    -------------
    DISPLAY
  end

  def conetent(id)
    return @item[id] if @item[id].is_a?(String)
    return '   ' if @item[id].nil?
  end

  def robot(time = 0, control = true)
    sleep(time) if time.is_a?(Integer)
    if @item.length == 9
      finish
      puts display
      warning("> [Try!]\n")
    end
    rand = (0..8).to_a.sample
    robot(time, control) if @item[rand]
    add_item(rand, control)
  end

  def winner
    {
      0 => [0, 1, 2],
      1 => [3, 4, 5],
      2 => [6, 7, 8],
      3 => [0, 3, 6],
      4 => [1, 4, 7],
      5 => [2, 5, 8],
      6 => [0, 4, 8],
      7 => [2, 4, 6]
    }
  end

  def reset
    @amount = []
  end

  def fusion(amount)
    [@item[winner[amount][0]],
     @item[winner[amount][1]],
     @item[winner[amount][2]]]
  end

  def finish
    winner.length.times do
      len = @amount.length
      warning("> [Robots Winner!]\n") if fusion(len).all?(' X ')
      warning("> [Human Winner!]\n") if fusion(len).all?(' O ')
      @amount << true
    end
  end

  def add_item(id, is_robot = false)
    case is_robot
    when false
      @item[id] = ' O ' unless @item[id]
      self
    when true
      @item[id] = ' X ' unless @item[id]
      self
    end
  end
end
