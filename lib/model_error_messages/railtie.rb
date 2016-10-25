module ModelErrorMessages
  class Railtie < ::Rails::Railtie
    initializer 'model_error_messages' do |_app|
      ActiveSupport.on_load(:action_view) do
        require 'model_error_messages/helpers'
        include ModelErrorMessages::Helpers
      end
    end
  end
end
