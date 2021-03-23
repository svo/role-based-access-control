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

  def to_json(role)
    role.map { |record| { "Id" => record.id, "Name" => record.name, "Parent" => parent_id(record) } }.to_json
  end

  private

  def validate(role)
    JSON::Validator.validate(ROLE_JSON_SCHEMA, role, strict: true)
  end

  def parent_id(record)
    record.parent.nil? ? 0 : record.parent.id
  end
end
