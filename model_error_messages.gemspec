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

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables = `git ls-files -- bin/*`.split('\n').map do |f|
    File.basename(f)
  end

  s.require_paths = ['lib']
end
