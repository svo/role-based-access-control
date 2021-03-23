# frozen_string_literal: true

require "sinatra"
require_relative "user_hierarchy"
require_relative "marshaller/role_json_marshaller"
require_relative "converter/role_converter"
require_relative "repository/role_repository"

module Facade
  def self.role_json_marshaller
    @role_json_marshaller ||= RoleJsonMarshaller.new
  end

  def self.user_hierarchy
    @user_hierarchy ||= UserHierarchy.new(RoleConverter.new, RoleRepository.new)
  end
end

post "/role" do
  Facade.user_hierarchy.create_role Facade.role_json_marshaller.from_json request.body.read
end

get "/role" do
  Facade.role_json_marshaller.to_json Facade.user_hierarchy.retrieve_role
end
