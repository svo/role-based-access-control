# frozen_string_literal: true

class Role
  def initialize(id, name)
    @id = id
    @name = name
  end

  attr_reader :id, :name

  def ==(other)
    @id == other.id && @name == other.name
  end
end
