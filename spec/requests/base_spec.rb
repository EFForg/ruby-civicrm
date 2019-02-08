require 'spec_helper'
require 'rest_client'
require 'ostruct'

describe "API Bindings" do

  let(:client){ authorized_civicrm_client }

  it "should not fetch from network while initializing a new Resource" do
    expect(client).not_to receive(:post)
    CiviCrm::Contact.new(id: "someid")
  end

  describe "exception handler" do
    let(:client){ CiviCrm::Client }

    it "should raise CiviCrm::Errors::BadRequest on 400" do
      exception = RestClient::Exception.new(nil, 400)
      expect(RestClient::Request).to receive(:execute).and_raise(exception)
      expect { client.execute!({}) }.to raise_error(CiviCrm::Errors::BadRequest)
    end

    it "should raise CiviCrm::Errors::Unauthorized on 401" do
      exception = RestClient::Exception.new(nil, 401)
      expect(RestClient::Request).to receive(:execute).and_raise(exception)
      expect { client.execute!({}) }.to raise_error(CiviCrm::Errors::Unauthorized)
    end

    it "should raise CiviCrm::Errors::Forbidden on 403" do
      exception = RestClient::Exception.new(nil, 403)
      expect(RestClient::Request).to receive(:execute).and_raise(exception)
      expect { client.execute!({}) }.to raise_error(CiviCrm::Errors::Forbidden)
    end

    it "should raise CiviCrm::Errors::NotFound on 404" do
      exception = RestClient::Exception.new(nil, 404)
      expect(RestClient::Request).to receive(:execute).and_raise(exception)
      expect { client.execute!({}) }.to raise_error(CiviCrm::Errors::NotFound)
    end

    it "should raise CiviCrm::Errors::InternalError on 500" do
      exception = RestClient::Exception.new(nil, 500)
      expect(RestClient::Request).to receive(:execute).and_raise(exception)
      expect { client.execute!({}) }.to raise_error(CiviCrm::Errors::InternalError)
    end

    it "should raise CiviCrm::Errors::Unauthorized if site_key is not provided" do
      CiviCrm.site_key = nil
      expect { client.request('get', 'test') }.to raise_error(CiviCrm::Errors::Unauthorized)
    end
  end
end
