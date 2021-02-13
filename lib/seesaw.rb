# frozen_string_literal: true

# Represent the seesaw on the island. depending on the weights on each side, it returns the result.
class Seesaw
  def initialize(number, another_number)
    @comparision_result = number <=> another_number
  end

  def same_weight?
    @comparision_result.zero?
  end

  def heavier?
    @comparision_result == 1
  end

  def lighter?
    @comparision_result == -1
  end
end
