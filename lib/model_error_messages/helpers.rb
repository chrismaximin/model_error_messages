module ModelErrorMessages
  module Helpers
    include ActionView::Helpers::TagHelper

    def model_error_messages(model, options = {})
      return '' if model.nil?
      return '' if model.errors.full_messages.empty?
      config = local_config(options)
      errors_wrapper(model, config)
    end

    private

    def errors_wrapper(model, config)
      class_attr = wrapper_class_attr(model, config)

      content_tag(:div, class: class_attr) do
        [
          config.prepend_html,
          errors_list(model, config),
          config.append_html
        ].join.html_safe
      end
    end

    def wrapper_class_attr(model, config)
      if config.classes.is_a?(Proc)
        config.classes.call(model)
      else
        config.classes
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

    def local_config(options)
      config = ModelErrorMessages.configuration.clone
      options.each_pair do |k, v|
        config.send(k.to_s + '=', v)
      end
      config
    end
  end
end
