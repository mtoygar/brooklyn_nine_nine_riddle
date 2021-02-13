# frozen_string_literal: true

# Represent islanders on the island
class Islander
  attr_reader :weight, :index

  def initialize(weight, index)
    @weight = weight
    @index = index
  end
end
