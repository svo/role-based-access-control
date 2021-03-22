# frozen_string_literal: true

class Role
  def initialize(id, name)
    @id = id
    @name = name
  end

  attr_reader :id, :name

  attr_accessor :parent

  def ==(other)
    @id == other.id && @name == other.name && @parent == other.parent
  end
end
