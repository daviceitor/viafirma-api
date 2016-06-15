require 'spec_helper'

describe Viafirma::Api::Facade do

  let(:facade){ Viafirma::Api::Facade }

  describe "#prepare_sign_request" do

    let(:client){ double("Client") }
    before(:each){ allow(Viafirma::Api::Client).to receive(:new).and_return(client) }

    it "should encode document content before send the soap request" do
      allow(client).to receive(:call).with(:prepare_sign_request, message: hash_including(document_content: Base64.encode64('content')))
      facade.new({}).prepare_sign_request('1234', 'name', 'content', 'return.url', {metadata_key: 'metadata_value'})
    end

    #IMPORTANT IF THE KEY IS NOT PRESENT THE API RESPONDS WITH NULLPOINTEREXCEPTION!!
    it "should include 'metadatos' in the soap request even if it's empty" do
      allow(client).to receive(:call).with(:prepare_sign_request, message: hash_including(metadatos: {}))
      facade.new({}).prepare_sign_request('1234', 'name', 'content', 'return.url')
    end

  end

end