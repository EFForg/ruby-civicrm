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

## Useful links

* https://docs.civicrm.org/dev/en/latest/api/interfaces/#rest-interface
* http://drupal.demo.civicrm.org/civicrm/api/explorer

## Acknowledgements

Created by [Iskander Haziev](https://github.com/gvalmon). Maintained by [EFF](https://www.eff.org/).
