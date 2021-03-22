# frozen_string_literal: true

require "sinatra"
require_relative "user_hierarchy"
require_relative "marshaller/role_json_marshaller"
require_relative "converter/role_converter"
require_relative "repository/role_repository"

module Facade
  def self.role_json_marshaller
    RoleJsonMarshaller.new
  end

  def self.user_hierarchy
    UserHierarchy.new(RoleConverter.new, RoleRepository.new)
  end
end

post "/create-role" do
  Facade.user_hierarchy.create_role Facade.role_json_marshaller.from_json request.body.read
end
