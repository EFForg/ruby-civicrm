module CiviCrm
  class FinancialType < BaseResource
    entity :financial_type

    @@_financial_type_cache = {}

    def self.get(name, cache: true, create: Rails.env.development?)
      cache_key = name

      if cache && @@_financial_type_cache.key?(cache_key)
        return @@_financial_type_cache[cache_key]
      end

      type = find_by("name" => name)
      type ||= create(name: name) if create

      if type
        @@_financial_type_cache[cache_key] = type.id if cache
        return type.id
      end

      raise Errors::NotFound.new(
        "FinancialType with name=#{name}"
      )
    end
  end
end
