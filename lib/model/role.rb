# frozen_string_literal: true

class Role
  def initialize(id)
    @id = id
  end

  attr_reader :id

  def ==(other)
    @id == other.id
  end
end
