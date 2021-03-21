# frozen_string_literal: true

require "json-schema"

class RoleJsonMarshaller
  def from_json(json)
    raise ArgumentError, "Invalid role JSON" unless validate(json)

    JSON.parse(json)
  end

  private

  def validate(role)
    JSON::Validator.validate({
                               "type" => "object",
                               "required" => %w[Id Name Parent],
                               "properties" => {
                                 "Id" => { "type" => "integer" },
                                 "Name" => { "type" => "string" },
                                 "Parent" => { "type" => "integer" }
                               }
                             }, role)
  end
end
