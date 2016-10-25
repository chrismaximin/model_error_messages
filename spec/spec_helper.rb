require 'model_error_messages'

RSpec.configure do |config|
  config.order = :random
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

  config.before(:each) do
    ModelErrorMessages.configuration.reset
  end
end
