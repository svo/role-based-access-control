# frozen_string_literal: true

class User
  def initialize(id, name, role)
    @id = id
    @name = name
    @role = role
  end

  attr_reader :id, :name, :role

  def ==(other)
    @id == other.id && @name == other.name && @role == other.role
  end
end
