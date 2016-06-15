require 'savon'

module ViafirmaApi
  class Client

    def initialize(credentials)
      validate(credentials)
      @client = Savon.client(wsdl: self.class.wsdl(credentials), basic_auth: [credentials[:user], credentials[:apikey]])
    end

    def self.wsdl(credentials)
      "http://#{credentials[:server]}:#{credentials[:port] || 80}/inbox/serviceWS?wsdl"
    end

    def call(*args)
      response = @client.call(*args)
      parse_response(response.body)
    end

    def parse_response(response)
      response_key = response.keys.detect{|k,v| k.to_s.end_with?('_response')}
      data = response[response_key][:return]
    
      if data[:error]
        raise "#{data[:response_code]}: #{data[:message]}"
      else
        data
      end
    end

    private

    def validate(credentials)
      raise "Server endpoint missing!!" if credentials[:server].blank?
      raise "User can't be blank!!" if credentials[:user].blank?
      raise "Apikey can't be blank!!" if credentials[:apikey].blank?
    end
  end
end