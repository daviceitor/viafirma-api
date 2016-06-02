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

  describe "#call" do
    let(:response_body){ {:ping_response=>{:return=>{:error=>false, :message=>nil, :response_code=>"SUCCESS", :result=>"pingResponse"}, :"@xmlns:ns2"=>"http://tray.viavansi.com"}} }
    let(:response){ double("Savon::Response", :body => response_body) }
    let(:savon_client){ double("Savon::Client") }

    before(:each){ allow(Savon).to receive(:client).and_return(savon_client) }

    it "should invoke savon call method with the same args" do
      c = client.new(config)
      expect(savon_client).to receive(:call).with(:ping, message: {param: 'pingResponse'}).and_return(response)
      c.call(:ping, message: {param: 'pingResponse'})
    end

    it "should parse response" do
      c = client.new(config)
      allow(savon_client).to receive(:call).and_return(response)
      expect(c).to receive(:parse_response).with(response_body)
      c.call(:ping)
    end
  end

  describe "#parse_response" do

    it "should return the result for valid responses" do
      response_body = {:method_response=>{:return=>{:error=>false, :message=>nil, :response_code=>"SUCCESS", :result=>"methodResponse"}, :"@xmlns:ns2"=>"http://tray.viavansi.com"}}
      expect(client.new(config).parse_response(response_body)).to eq response_body[:method_response][:return]
    end

    it "should raise error with a message" do
      error_response = {:method_response=>{:return=>{:error=>true, :message=>"I'm a error!", :response_code=>"ERROR_0"}, :"@xmlns:ns2"=>"http://tray.viavansi.com"}}
      expect{client.new(config).parse_response(error_response)}.to raise_error("ERROR_0: I'm a error!")
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