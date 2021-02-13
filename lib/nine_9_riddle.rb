# frozen_string_literal: true

require 'active_support/all'

class Nine9Riddle
  def initialize(weight_array)
    @a, @b, @c, @d, @e, @f, @g, @h, @i, @j, @k, @l = weight_array
    @comparision_count = 0
  end

  def calculate
    initial_result = compare([a, b, c, d], [e, f, g, h])
    if initial_result.zero?
      # outlier is either i, j, k or l
      if compare([a, b], [i, j]).zero?
        # outlier is either k or l
        compare(a, k).zero? ? 11 : 10
      else
        # outlier is either i or j
        compare(a, i).zero? ? 9 : 8
      end
    else
      # outlier is either a, b, c, d, e, f, g, or h
      result = compare([a, b, e], [c, d, f])
      if result.zero?
        # outlier is either g or h
        compare(a, g).zero? ? 7 : 6
      elsif initial_result == -1
        if result == -1
          # outlier is either a, b or f
          last_result = compare(a, b)
          case last_result
          when 0 then 5 # f
          when 1 then 1 # b
          when -1 then 0 # a
          end
        else
          # outlier is either c, d or e
          last_result = compare(c, d)
          case last_result
          when 0 then 4 # e
          when 1 then 3 # d
          when -1 then 2 # c
          end
        end
      elsif result == -1
        last_result = compare(c, d)
        case last_result
        when 0 then 4 # e
        when 1 then 2 # c
        when -1 then 3 # d
        end
      # outlier is either c, d or e
      else
        # outlier is either a, b or f
        last_result = compare(a, b)
        case last_result
        when 0 then 5 # f
        when 1 then 0 # a
        when -1 then 1 # b
        end
      end
    end
  end

  private

  attr_reader :a, :b, :c, :d, :e, :f, :g, :h, :i, :j, :k, :l
  attr_accessor :comparision_count

  def compare(array_1, array_2)
    self.comparision_count = comparision_count + 1
    raise 'comparision count cannot be bigger than 3' if comparision_count > 3

    Array.wrap(array_1).sum <=> Array.wrap(array_2).sum
  end
end
