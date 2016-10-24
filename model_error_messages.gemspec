$LOAD_PATH.push File.expand_path('../lib', __FILE__)
require 'model_error_messages/version'

Gem::Specification.new do |s|
  s.name = 'model_error_messages'
  s.version = ModelErrorMessages::VERSION::STRING
  s.summary =
    'Simple Rails helper which displays a HTML div' \
    ' with the errors attached to a model.'
  s.authors = ['Christophe Maximin']
  s.email = 'christophe.maximin@gmail.com'
  s.homepage = 'https://github.com/christophemaximin/model_error_messages'
  s.licenses = ['MIT']

  s.platform = Gem::Platform::RUBY

  s.add_development_dependency 'rspec', '~> 3.5'
  s.add_development_dependency 'guard-rspec', '~> 4.7'
  s.add_development_dependency 'guard-rubocop', '~> 1.2'
  s.add_development_dependency 'rb-inotify', '~> 0.9'
  s.add_development_dependency 'rb-fsevent', '~> 0.9'
  s.add_development_dependency 'rb-fchange', '~> 0'

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split('\n').map do |f|
    File.basename(f)
  end

  s.require_paths = ['lib']
end
