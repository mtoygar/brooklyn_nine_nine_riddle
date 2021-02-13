# frozen_string_literal: true

require 'minitest/autorun'
require 'spy/integration'
require 'active_support'
require 'nine_9_riddle'

class Nine9RiddleTest < ActiveSupport::TestCase
  (0..11).each do |outlier_index|
    test "#{outlier_index}th person is heavier" do
      assert_equal outlier_index, Nine9Riddle.new(create_weight_array(outlier_index, 0.1)).solve
    end

    test "#{outlier_index}th person is lighter" do
      assert_equal outlier_index, Nine9Riddle.new(create_weight_array(outlier_index, -0.1)).solve
    end

    test "uses seesaw 3 times when #{outlier_index}th person is heavier" do
      seesaw_spy = Spy.on(Seesaw, :new).and_call_through

      Nine9Riddle.new(create_weight_array(outlier_index, 0.1)).solve

      assert_equal 3, seesaw_spy.calls.count
    end

    test "uses seesaw 3 times when #{outlier_index}th person is lighter" do
      seesaw_spy = Spy.on(Seesaw, :new).and_call_through

      Nine9Riddle.new(create_weight_array(outlier_index, -0.1)).solve

      assert_equal 3, seesaw_spy.calls.count
    end
  end

  private

  def create_weight_array(outlier_index, weight_difference)
    weight_array = Array.new(12, 1)
    weight_array[outlier_index] = weight_array.at(outlier_index) + weight_difference

    weight_array
  end
end
