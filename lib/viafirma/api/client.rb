require 'savon'

module Viafirma
  module Api
    class Client
      extend Savon::Model

      def initialize config
        validate(config)
        self.class.client(wsdl: self.class.wsdl(config), wsse_auth: [config[:user], config[:apikey]])
      end

      def self.wsdl config
        "http://#{config[:server]}:#{config[:port] || 80}/inbox/serviceWS?wsdl"
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