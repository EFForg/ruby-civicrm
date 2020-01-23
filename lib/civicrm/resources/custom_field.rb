module CiviCrm
  class CustomField < BaseResource
    entity :custom_field

    @@_custom_field_cache = {}

    def self.[](entity, field, cache: true)
      cache_key = [entity.underscore, field].join("/")

      if cache && @@_custom_field_cache.key?(cache_key)
        return @@_custom_field_cache[cache_key]
      end

      field = find_by(
        "custom_group_id.extends" => entity,
        "custom_group_id.name" => entity,
        "name" => field,
        "options" => { "or" => [["custom_group_id.extends", "custom_group_id.name"]] }
      )

      if field
        @@_custom_field_cache[cache_key] = field if cache
        return field
      end

      raise Errors::NotFound.new(
        "CustomField of #{entity} with name=#{field}"
      )
    end

    def key
      "custom_#{id}"
    end
  end
end
