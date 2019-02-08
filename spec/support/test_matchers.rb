RSpec::Matchers.define :be_listable_resource do |expected|
  match do |actual|
    client = authorized_civicrm_client
    subject = actual.class
    test_response_hash = send(:"test_#{subject.name.demodulize.underscore}_array")

    expect(client).
      to receive(:post).
          exactly(:once).
          and_return(test_response(test_response_hash))

    expect(subject.all).to be_a_kind_of(Array)
  end
end

RSpec::Matchers.define :be_updatable_resource do |expected|
  match do |actual|
    client = authorized_civicrm_client
    subject = actual.class

    expect(client).
      to receive(:post).
          exactly(:once).
          and_return(test_response(test_contact({name: "foo"})))

    expect(client).
      to receive(:put).
          exactly(:once).
          and_return(test_response(test_contact({name: "bar"})))

    c = subject.find("resource_id")
    expect(c.name).to eq("foo")

    c.name = "bar"
    c.save
    expect(c.name).to eq("bar")
  end
end

RSpec::Matchers.define :be_deleteable_resource do |expected|
  match do |actual|
    client = authorized_civicrm_client
    subject = actual.class

    expect(client).
      to receive(:post).
          exactly(:once).
          and_return(test_response(test_contact({name: "foo"})))

    expect(client).
      to receive(:post).
          exactly(:once).
          and_return(test_response(test_contact({name: "bar"})))

    c = subject.find("resource_id")
    c.delete
  end
end
