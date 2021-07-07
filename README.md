# CiviCRM Client

## Installation

```
$ gem install civicrm
```

## Getting started

```ruby
# Required config
CiviCrm.api_base = "https://www.example.org/path/to/civi/codebase/"
CiviCrm.site_key = "YOUR_SITE_KEY"
CiviCrm.api_key = "..."

# Optional config
CiviCrm.timeout = 60 # Change request timeout in seconds (nil to disable)
```

## CiviCrm Objects

```ruby
# Get list of contacts
CiviCrm::Contact.all

# Create contact
CiviCrm::Contact.create(contact_type: "Organization", organization_name: "test")

# Find and delete
CiviCrm::Contact.find(1).delete
```

## Testing

```
$ bundle exec rspec spec
```

## Debugging

Set these `ENV` options to a truthy value to print CiviCRM REST API data.

```DEBUG_CIVICRM_REQUEST```

Example: 

```
[CiviCRM] [REQ] [FinancialType] [get] {"method":"post","timeout":null,"headers":{"user_agent":"CiviCrm RubyClient/1.3.6","request_id":"8168cbfc-36d1-4967-bf94-8fd72fd48455"},"payload":{"json":"{\"id\":12}"},"url":"..."}
```

```DEBUG_CIVICRM_RESPONSE```

Example:

```
[CiviCRM] [RES] [FinancialType] [get] {"is_error":0,"version":3,"count":1,"id":12,"values":{"12":{"id":"12","name":"Matching Gift","is_deductible":"0","is_active":"1"}}}
```


## Useful links

* https://docs.civicrm.org/dev/en/latest/api/interfaces/#rest-interface
* http://drupal.demo.civicrm.org/civicrm/api/explorer

## Acknowledgements

Created by [Iskander Haziev](https://github.com/gvalmon). Maintained by [EFF](https://www.eff.org/).
