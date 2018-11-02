module CiviCrm
  module Actions
    module Update
      def update(attrs = {})
        attrs = attrs.reverse_merge(changes.transform_values(&:last))

        params = {
          'entity' => self.class.entity_class_name,
          'action' => 'create',
          'id' => id
        }.merge(attrs)

        response = CiviCrm::Client.request(:post, params)
        refresh_from(response.first.to_hash)

        @previously_changed = changes
        @changed_attributes.clear

        self
      end

      def save
        update()
      end
    end
  end
end
