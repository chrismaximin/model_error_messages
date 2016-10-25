module ModelErrorMessages
  class Configuration
    attr_accessor :single_error_in_paragraph
    attr_accessor :prepend_html
    attr_accessor :append_html
    attr_accessor :classes
    attr_writer :configuration

    def initialize
      reset
      true
    end

    def reset
      @single_error_in_paragraph = true
      @prepend_html = ''
      @append_html = ''
      @classes = lambda do |model|
        [
          'alert',
          'alert-danger',
          model.class.model_name.param_key + '-error-messages'
        ].join(' ')
      end
    end
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end
end
