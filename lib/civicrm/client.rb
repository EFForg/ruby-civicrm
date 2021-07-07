module CiviCrm
  class Client
    class << self

      # Returns parsed class inherited from CiviCrm::Resource
      def request(method, params = {})
        unless CiviCrm.site_key
          raise CiviCrm::Errors::Unauthorized,
                "Please specify CiviCrm.site_key"
        end

        headers = {
          :user_agent => "CiviCrm RubyClient/#{CiviCrm::VERSION}",
          :request_id => SecureRandom.uuid
        }

        opts = {
          :method => :post,
          :timeout => CiviCrm.timeout,
          :headers => headers
        }

        params = params.dup

        entity = params.delete("entity")
        raise ArgumentError, "params must include entity" unless entity

        action = params.delete("action")
        raise ArgumentError, "params must include action" unless action

        method = { entity: entity, action: action }.to_query

        opts[:payload] = { json: JSON.dump(params) }
        opts[:url] = CiviCrm.api_url(method)

        response = nil

        puts("[CiviCRM] [REQ] [#{entity}] [#{action}] #{JSON.dump(opts)}") if ENV["DEBUG_CIVICRM_REQUEST"]

        CiviCrm.time(params['entity'], params['action']) do
          response = execute(opts)
        end

        puts("[CiviCRM] [RES] [#{entity}] [#{action}] #{response}") if ENV["DEBUG_CIVICRM_RESPONSE"]

        body, code = response.body, response.code

        parsed_response = JSON.parse(body)

        if parsed_response["is_error"] == 1
          raise Error, parsed_response["error_message"]
        end

        values = parsed_response.fetch("values")
        values.is_a?(Hash) ? values.values : values
      end

      def execute(opts)
        RestClient::Request.execute(opts)
      rescue RuntimeError => e
        case e.http_code.to_i
        when 400
          raise CiviCrm::Errors::BadRequest, e.http_body
        when 401
          raise CiviCrm::Errors::Unauthorized, e.http_body
        when 403
          raise CiviCrm::Errors::Forbidden, e.http_body
        when 404
          raise CiviCrm::Errors::NotFound, e.http_body
        when 500
          raise CiviCrm::Errors::InternalError, e.http_body
        else
          raise e
        end
      end
    end
  end
end
