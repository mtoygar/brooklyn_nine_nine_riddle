# frozen_string_literal: true

require 'active_support'
require 'minitest/autorun'
require 'nine_9_riddle'

class Nine9RiddleTest < ActiveSupport::TestCase
  (0..11).each do |index|
    test "#{index}th person is heavier" do
      assert_equal index, Nine9Riddle.new(create_weight_array(index, 0.1)).calculate
    end

    test "#{index}th person is lighter" do
      assert_equal index, Nine9Riddle.new(create_weight_array(index, -0.1)).calculate
    end
  end

  private

  def create_weight_array(index, weight_difference)
    weight_array = Array.new(12, 1)
    weight_array[index] = weight_array.at(index) + weight_difference

    weight_array
  end
end
