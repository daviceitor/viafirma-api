require 'spec_helper'
require 'viafirma/facade'

describe Viafirma::Api::Facade do

  let(:facade){ Viafirma::Api::Facade }

  describe "#ping integration spec" do

    it "should ping web service" do
      expect(facade.new.ping).to include(:ping_response)
    end

  end

end