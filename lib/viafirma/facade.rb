require 'active_support/core_ext/hash/indifferent_access'

module Viafirma
  module Api
    class Facade
      
      def initialize
        config = YAML.load(File.read("#{File.dirname(__FILE__)}/config.yml")).with_indifferent_access
        @client = Client.new(config)
      end

      def ping
        @client.call(:ping, message: { param: 'pingResponse' })
      end

      def prepare_sign_request(person_id, document_name, document_content, return_url, metadata={})
        params = {
          person_id: person_id,
          document_name: document_name,
          document_content: Base64.encode64(document_content),
          return_url: return_url,
          metadatos: metadata
        }
        @client.call(:prepare_sign_request, message: params)
      end

    end
  end
end
