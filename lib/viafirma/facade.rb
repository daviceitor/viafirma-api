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

    end
  end
end
