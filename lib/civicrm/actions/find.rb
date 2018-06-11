module CiviCrm
  module Actions
    module Find
      module ClassMethods
        def find(id)
          params = {'entity' => entity_class_name, 'action' => 'getsingle', 'id' => id}
          response = CiviCrm::Client.request(:get, params)

          if response.first.nil?
            raise Error, "Couldn't find #{entity_class_name}##{id}"
          end

          Resource.build_from(response.first, params)
        end
      end

      def self.included(base)
        base.extend(ClassMethods)
      end
    end
  end
end