require 'cgi'

module ModelErrorMessages
  module Helpers
    def model_error_messages(model, options = {})
      return '' if model.nil?
      return '' if model.errors.full_messages.empty?

      private_helpers = ModelErrorMessages::PrivateHelpers
      config = private_helpers.local_config(options)
      private_helpers.errors_wrapper(model, config)
    end
  end

  module PrivateHelpers
    def self.errors_wrapper(model, config)
      class_attr = wrapper_class_attr(model, config)

      div_string = [
        config.prepend_html,
        errors_list(model, config),
        config.append_html
      ].join.html_safe

      tag(:div, div_string, class: class_attr)
    end

    def self.wrapper_class_attr(model, config)
      if config.classes.is_a?(Proc)
        config.classes.call(model)
      else
        config.classes
      end
    end

    def self.errors_list(model, config)
      messages = model.errors.full_messages

      if messages.count == 1 && config.single_error_in_paragraph
        return tag(:p, CGI.escapeHTML(messages.first))
      end

      ul_string = messages.map do |message|
        tag(:li, CGI.escapeHTML(message))
      end.join.html_safe

      tag(:ul, ul_string)
    end

    def self.local_config(options)
      config = ModelErrorMessages.configuration.clone
      options.each_pair do |k, v|
        config.send(k.to_s + '=', v)
      end
      config
    end

    def self.tag(name, value, attributes = {})
      string_attributes = attributes.inject('') do |attrs, pair|
        unless pair.last.nil?
          attrs << %( #{pair.first}="#{CGI.escapeHTML(pair.last.to_s)}")
        end
        attrs
      end.html_safe

      "<#{name}#{string_attributes}>#{value}</#{name}>".html_safe
    end
  end
end
