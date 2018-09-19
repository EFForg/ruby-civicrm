require 'spec_helper'

describe CiviCrm::Contact do
  it { should be_listable_resource }
  #it { should be_updatable_resource }

  it "should return contact on create" do
    client = authorized_civicrm_client

    expect(client).
      to receive(:post).
          exactly(:once).
          and_return(test_response(test_contact))

    expect(CiviCrm::Contact.create).to be_a_kind_of(CiviCrm::Contact)
  end
end
