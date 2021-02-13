# frozen_string_literal: true

require 'active_support/all'
require 'islander'
require 'seesaw'

# Solver for the "brain teaser" taken from Brooklyn Nine Nine S2E18(aka 12 islanders puzzle)
class Nine9Riddle
  def initialize(weight_array)
    @a, @b, @c, @d, @e, @f, @g, @h, @i, @j, @k, @l = initialize_islanders(weight_array)
    @comparision_count = 0
  end

  def solve
    initial_result = compare([a, b, c, d], [e, f, g, h])

    return find_outlier_if_initial_result_is_same.index if initial_result.same_weight?

    find_outlier_if_initial_result_is_different(initial_result).index
  end

  private

  attr_reader :a, :b, :c, :d, :e, :f, :g, :h, :i, :j, :k, :l
  attr_accessor :comparision_count

  def initialize_islanders(weight_array)
    weight_array.map.with_index { |weight, index| Islander.new(weight, index) }
  end

  def find_outlier_if_initial_result_is_same
    # outlier is either i, j, k or l
    if compare([a, b], [i, j]).same_weight?
      # outlier is either k or l
      find_outlier_two_way(result: compare(a, k), if_same: l, if_different: k)
    else
      # outlier is either i or j
      find_outlier_two_way(result: compare(a, i), if_same: j, if_different: i)
    end
  end

  def find_outlier_if_initial_result_is_different(initial_result)
    # outlier is either a, b, c, d, e, f, g, or h
    second_result = compare([a, b, e], [c, d, f])
    if second_result.same_weight?
      # outlier is either g or h
      find_outlier_two_way(result: compare(a, g), if_same: h, if_different: g)
    elsif second_result.lighter?
      find_outlier_if_second_result_is_lighter(initial_result)
    elsif second_result.heavier?
      find_outlier_if_second_result_is_heavier(initial_result)
    end
  end

  def find_outlier_if_second_result_is_lighter(initial_result)
    if initial_result.lighter?
      # outlier is either a, b or f
      find_outlier_three_way(result: compare(a, b), if_same: f, if_heavier: b, if_lighter: a)
    elsif initial_result.heavier?
      # outlier is either c, d or e
      find_outlier_three_way(result: compare(c, d), if_same: e, if_heavier: c, if_lighter: d)
    end
  end

  def find_outlier_if_second_result_is_heavier(initial_result)
    if initial_result.lighter?
      # outlier is either c, d or e
      find_outlier_three_way(result: compare(c, d), if_same: e, if_heavier: d, if_lighter: c)
    elsif initial_result.heavier?
      # outlier is either a, b or f
      find_outlier_three_way(result: compare(a, b), if_same: f, if_heavier: a, if_lighter: b)
    end
  end

  def find_outlier_two_way(result:, if_same:, if_different:)
    result.same_weight? ? if_same : if_different
  end

  def find_outlier_three_way(result:, if_same:, if_heavier:, if_lighter:)
    return if_same if result.same_weight?
    return if_heavier if result.heavier?

    if_lighter if result.lighter?
  end

  def compare(islander_array, another_islander_array)
    self.comparision_count = comparision_count + 1
    raise 'comparision count cannot be bigger than 3' if comparision_count > 3

    Seesaw.new(
      Array.wrap(islander_array).sum(&:weight),
      Array.wrap(another_islander_array).sum(&:weight)
    )
  end
end
