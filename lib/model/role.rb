# frozen_string_literal: true

class Role
  def initialize(id, name)
    @id = id
    @name = name
    @children = []
  end

  attr_reader :id, :name

  attr_accessor :parent, :children

  def subordinate(result = [])
    @children.each do |child|
      result.push(child)
      child.subordinate(result)
    end

    result
  end

  def add_child(child)
    @children.push child
  end

  def ==(other)
    @id == other.id && @name == other.name && @parent == other.parent && @children == other.children
  end
end
