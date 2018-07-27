module CiviCrm
  module Actions
    module Find
      module ClassMethods
        def find(id)
          params = {'entity' => entity_class_name, 'action' => 'get', 'id' => id}
          response = CiviCrm::Client.request(:get, params)

          Resource.build_from(response, params).first or
            raise Error, "Couldn't find #{entity_class_name}##{id}"
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end
