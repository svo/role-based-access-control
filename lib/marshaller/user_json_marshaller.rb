# frozen_string_literal: true

require "json-schema"

USER_JSON_SCHEMA = {
  "type" => "array",
  "items" => {
    "type" => "object",
    "properties" => {
      "Id" => { "type" => "integer" },
      "Name" => { "type" => "string" },
      "Role" => { "type" => "integer" }
    }
  }
}.freeze

class UserJsonMarshaller
  def from_json(json)
    raise ArgumentError, "Invalid user JSON" unless validate(json)

    JSON.parse(json)
  end

  def to_json(user)
    user.map { |record| { "Id" => record.id, "Name" => record.name, "Role" => record.role.id } }.to_json
  end

  private

  def validate(user)
    JSON::Validator.validate(USER_JSON_SCHEMA, user, strict: true)
  end
end
