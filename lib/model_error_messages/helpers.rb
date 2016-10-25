module ModelErrorMessages
  module Helpers
    def model_error_messages(model, options = {})
      return '' if model.nil?
      return '' if model.errors.full_messages.empty?
      config = local_config(options)
      errors_wrapper(model, config)
    end

    private

    def errors_wrapper(model, config)
      class_attr = config.classes.call(model).join(' ')
      content_tag(:div, class: class_attr) do
        [:prepended, :errors_list, :appended].map do |method|
          send(method, model, config)
        end.join.html_safe
      end
    end

    def errors_list(model, config)
      messages = model.errors.full_messages

      if messages.count == 1 && config.single_error_in_paragraph
        return content_tag(:p, messages.first)
      end

      content_tag(:ul) do
        messages.map do |message|
          content_tag(:li, message)
        end.join.html_safe
      end
    end

    def prepended(model, config)
      config.prepend_html.call(model)
    end

    def appended(model, config)
      config.append_html.call(model)
    end

    def local_config(options)
      config = ModelErrorMessages.configuration.clone
      options.each_pair do |k, v|
        config.send(k.to_s + '=', v)
      end
      config
    end
  end
end

module ActionView
  module Helpers
    module TextHelper
      include ::ModelErrorMessages::Helpers
    end
  end
end
