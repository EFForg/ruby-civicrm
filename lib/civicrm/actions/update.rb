module CiviCrm
  module Actions
    module Update
      def update(attrs = {})
        params = {
          'entity' => self.class.entity_class_name,
          'action' => 'create',
          'id' => id
        }.merge(attributes).merge(attrs)

        response = CiviCrm::Client.request(:post, params)
        refresh_from(response.first.to_hash)
      end

      def save
        @previously_changed = changes
        @changed_attributes.clear
        update()
      end
    end
  end
end
