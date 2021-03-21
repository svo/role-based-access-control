# frozen_string_literal: true

require "json-schema"

ROLE_JSON_SCHEMA = {
  "type" => "array",
  "items" => {
    "type" => "object",
    "properties" => {
      "Id" => { "type" => "integer" },
      "Name" => { "type" => "string" },
      "Parent" => { "type" => "integer" }
    }
  }
}.freeze

class RoleJsonMarshaller
  def from_json(json)
    raise ArgumentError, "Invalid role JSON" unless validate(json)

    JSON.parse(json)
  end

  private

  def validate(role)
    JSON::Validator.validate(ROLE_JSON_SCHEMA, role, strict: true)
  end
end
