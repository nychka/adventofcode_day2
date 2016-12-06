#!/usr/bin/env ruby

gem "minitest"
require_relative 'test_helper'
require 'bathroom_code'
require 'minitest/autorun'

class BathroomCodeTest < Minitest::Test
  def setup
    # 1 2 3
    # 4 5 6
    # 7 8 9
    @code = BathroomCode.new
    @code.load_keypad('example/default.txt')
    @numbers = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  end
  def test_set_keypad_input
    keypad = "123\n456\n789"
    @code.set_keypad(keypad)
    assert_equal(@code.numbers, @numbers)
  end
  def test_load_keypad
    @code.load_keypad('example/default.txt')
    assert_equal(@code.numbers, @numbers)
  end
  def test_current_coords
    assert_equal(@code.start_cords, @code.current_coords)
  end
  def test_current_number
    assert_equal(@code.current_number, 5)
  end
  def test_start_point
    assert_equal(@code.start_point, 5)
  end
  def test_numbers
    assert_equal(@numbers[1][2], 6)
  end
  # move up from 5 to 2
  def test_move_up
    assert_equal(@code.move_up, 2)
  end
  # move down from 5 to 8
  def test_move_down
    assert_equal(@code.move_down, 8)
  end
  # move left from 5 to 4
  def test_move_left
    assert_equal(@code.move_left, 4)
  end
  # move right from 5 to 6
  def test_move_right
    assert_equal(@code.move_right, 6)
  end
  # протестувати перехід вгору з позиціі 1
  def test_move_up_outside
    @code.current_coords = { y: 0, x: 0 }
    position = @code.move_up # position 1
    assert_equal(position, 1)
  end
  # протестувати перехід вниз з позиціі 7
  def test_move_down_outside
    @code.current_coords = { y: 2, x: 0 }
    position = @code.move_down # position 7
    assert_equal(position, 7)
  end
  # протестувати перехід вліво з позиціі 7
  def test_move_left_outside
    @code.current_coords = { y: 1, x: 0 }
    position = @code.move_left # position 4
    assert_equal(position, 4)
  end
  # протестувати перехід вправо з позиціі 6
  def test_move_right_outside
    @code.current_coords = { y: 1, x: 2 }
    position = @code.move_right # position 6
    assert_equal(position, 6)
  end
  # STAGE 2
  def test_read_u_symbol_as_move_up
    doc = "U"
    assert_equal(@code.read(doc), 2) # 2
  end
  def test_read_uu_symbols_as_double_move_ups
    doc = "UUUUUU"
    assert_equal(@code.read(doc), 2) # 2
  end
  def test_read_ur_symbols
    doc = "UR"
    assert_equal(@code.read(doc), 3) # 2
  end
  def test_read_urd_symbols
    doc = "URD"
    assert_equal(@code.read(doc), 6) # 2
  end
  def test_read_single_line_from_file
    file = 'example/single_line.txt'
    assert_equal(@code.read(file, true), 8)
  end
  #TODO: 
  def test_read_multiply_lines_from_file
    file = 'example/example.txt'
    assert_equal(@code.read(file, true), 1985)
  end
end
  