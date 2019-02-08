 module CiviCrm::TestResponses
  def test_response(body, code = 200)
    body = JSON.dump(is_error: 0, values: [body]) if !(body.kind_of? String)
    double(body: body, code: code)
  end

  def test_contact(params = {})
    {
      :id => '1',
      :contact_id => '1',
      :contact_type => 'Organization',
      :sort_name => 'Inner City Arts',
      :display_name => 'Inner City Arts',
      :name => 'Bruce Lee',
      :description => 'Foo bar',
      :created => '1345537759',
      :livemode => false
    }.merge(params)
  end

  def test_contact_array
    {
      :count => 3, :is_error => 0,
      :values => [test_contact, test_contact, test_contact]
    }
  end
end
