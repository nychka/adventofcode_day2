# Start your iteration here

class BathroomCode
  attr_accessor :current_coords, :current_number
  attr_reader :numbers

  def initialize
    #load_keypad('example/default.txt')
  end

  #def numbers
    # 1 2 3
    # 4 5 6
    # 7 8 9
    #[[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  #end
  def start_cords
    { x: 1, y: 1 }
  end
  def size
    numbers.length - 1
  end
  def start_point
    x = start_cords[:x]
    y = start_cords[:y]
    numbers[y][x] # 5
  end
  def set_keypad(input)
    arr = []
    input.lines.each do |line|
      line.gsub!(/\n|\t|\s/, '')
      arr << line.chars.map do |char| 
        (char =~ /[a-zA-Z0-9]/) ? char.to_i : nil
      end
    end
    @numbers = arr
  end
  def load_keypad(file_name)
    input = File.read(file_name)
    @numbers = set_keypad(input)
    @current_coords = start_cords
    @current_number = start_point
  end
  def read(document, file = false)
    document = File.read(document) if file
    code = ''
    document.lines.each do |line|
      line.chars.each do |char|
        #print "Current number: #{current_number}"
        case char
          when 'U' then move_up
          when 'R' then move_right
          when 'L' then move_left
          when 'D' then move_down
        end
      end
      code << current_number.to_s
    end
    code.to_i
  end
  def move_up
    x = current_coords[:x]
    y = current_coords[:y]
    y = y - 1 if y > 0
    @current_number = numbers[y][x]
    @current_coords = { x: x, y: y }
    current_number
  end
  def move_down
    x = current_coords[:x]
    y = current_coords[:y]
    y = y + 1 unless y >= size
    #p "x: #{x} y: #{y}"
    @current_number = numbers[y][x]
    @current_coords = { x: x, y: y }
    current_number
  end
  def move_left
    x = current_coords[:x]
    y = current_coords[:y]
    x = x - 1 if x > 0
    @current_number = numbers[y][x]
    @current_coords = { x: x, y: y }
    current_number
  end
  def move_right
    x = current_coords[:x]
    y = current_coords[:y]
    x = x + 1 if x < size
    @current_number = numbers[y][x]
    @current_coords = { x: x, y: y }
    current_number
  end
end