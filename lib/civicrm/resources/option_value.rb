module CiviCrm
  class OptionValue < BaseResource
    entity :option_value

    @@_option_value_cache = {}

    def self.get(group, name, cache: true, create: Rails.env.development?)
      cache_key = [group, name]

      if cache && @@_option_value_cache.key?(cache_key)
        return @@_option_value_cache[cache_key]
      end

      option = find_by(
        'name' => name,
        'option_group_id.title' => group
      )

      if !option && create
        group = OptionGroup.find_by!(title: group)
        option = create(option_group_id: group.id, name: name)
      end

      if option
        @@_option_value_cache[cache_key] = option.value if cache
        return option.value
      end

      raise Errors::NotFound.new(
        "#{group} with name=#{name}"
      )
    end
  end
end
