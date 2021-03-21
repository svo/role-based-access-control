# frozen_string_literal: true

class RoleJsonMarshaller
  def from_json(json)
    JSON.parse json
  end
end
