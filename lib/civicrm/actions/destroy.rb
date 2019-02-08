module CiviCrm
  module Actions
    module Destroy
      def delete
        params = {
          'entity' => self.class.entity_class_name,
          'action' => 'delete',
          'id' => id
        }

        response = CiviCrm::Client.request(:post, params)

        if response < 1
          raise Error, "Couldn't delete #{entity_class_name}##{id}"
        end
      end

      def delete!
        params = {
          'entity' => self.class.entity_class_name,
          'action' => 'delete',
          'skip_undelete' => 1,
          'id' => id
        }

        response = CiviCrm::Client.request(:post, params)

        if response < 1
          raise Error, "Couldn't delete #{entity_class_name}##{id}"
        end
      end
    end
  end
end
