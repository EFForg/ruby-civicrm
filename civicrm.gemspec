$:.unshift(File.join(File.dirname(__FILE__), 'lib'))

require 'civicrm/version'

spec = Gem::Specification.new do |s|
  s.name = 'civicrm'
  s.version = CiviCrm::VERSION
  s.summary = 'Ruby bindings for the CiviCRM API'
  s.description = 'See http://civicrm.org for details.'
  s.authors = ['Iskander Haziev']
  s.email = ['gvalmon@gmail.com']
  s.homepage = 'http://civicrm.org'
  s.executables = 'civicrm'
  s.require_paths = %w{lib}
  s.required_ruby_version = '>= 2.0'

  s.add_dependency('rest-client', '~> 2.0')
  s.add_dependency('activesupport')
  s.add_dependency('activemodel')
  s.add_dependency('nokogiri', '>= 1.10.8')

  s.add_development_dependency('rake')
  s.add_development_dependency('rspec', '~> 3.8')
  s.add_development_dependency('byebug')

  s.files = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- test/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
end
