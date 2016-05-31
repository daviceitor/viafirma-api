require 'spec_helper'
require 'viafirma/api/client'

describe Viafirma::Api::Client do

  let(:config){ { server: 'whatever', port: 11, user: 'test', apikey: '123' } }
  let(:client){ Viafirma::Api::Client }

  describe "#initialize" do

    it "should build a well formed client" do
      expect{ client.new(config) }.to_not raise_error
    end

    context "invalid config" do
      
      it "should raise error if server not specified" do
        expect{ client.new(config.merge(server: nil)) }.to raise_error(RuntimeError, /server/i)
      end

      it "should raise error if user not specified" do
        expect{ client.new(config.merge(user: nil)) }.to raise_error(RuntimeError, /user/i)
      end

      it "should raise error if apikey not specified" do
        expect{ client.new(config.merge(apikey: nil)) }.to raise_error(RuntimeError, /apikey/i)
      end

    end
  end

  describe ".wdsl" do

    it "should build wdsl url for viafirma platform" do
      expect(client.wsdl(config)).to eq("http://whatever:11/inbox/serviceWS?wsdl")
    end

    it "should use port 80 by default" do
      expect(client.wsdl(config.merge(port: nil))).to eq("http://whatever:80/inbox/serviceWS?wsdl")
    end

  end

end