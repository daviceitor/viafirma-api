require "viafirma/api/version"

module Viafirma
  module Api
    class Facade
      
      def initialize
        config = YAML.load(File.read("config.yml"))
        @client = Client.new(config)
      end

    end
  end
end
