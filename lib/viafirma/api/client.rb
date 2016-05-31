require 'savon'

module Viafirma
  module Api
    class Client

      def initialize config
        validate(config)
        @client = Savon.client(wsdl: self.class.wsdl(config), basic_auth: [config[:user], config[:apikey]])
      end

      def self.wsdl config
        "http://#{config[:server]}:#{config[:port] || 80}/inbox/serviceWS?wsdl"
      end

      def call *args
        response = @client.call(*args)
        parse_response(response.body)
      end

      def parse_response response
        response
      end

      private

      def validate(config)
        raise "Server endpoint missing!!" if config[:server].blank?
        raise "User can't be blank!!" if config[:user].blank?
        raise "Apikey can't be blank!!" if config[:apikey].blank?
      end
    end
  end
end