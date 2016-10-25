require 'spec_helper'
require 'ostruct'

class ModelStruct < OpenStruct
  def self.model_name
    OpenStruct.new(param_key: 'model')
  end
end

def mock_model_full_messages(errors_count)
  case errors_count
  when 0 then []
  when 1 then ['Title is missing']
  when 2 then ['Please select an author', 'Content is missing']
  else
    raise 'Please enter a valid `errors` count.'
  end
end

def mock_model(options = {})
  model = ModelStruct.new
  model.errors = OpenStruct.new
  model.errors.full_messages = mock_model_full_messages(options[:errors])
  model
end

describe 'Helpers' do
  include ActionView::Helpers::TextHelper

  describe '#model_error_messages' do
    attr_accessor :output_buffer
    subject { model_error_messages(mock_model) }

    it 'returns nothing if model is nil' do
      result = model_error_messages(nil)
      expect(result).to eql('')
    end

    it 'returns nothing if model has no errors' do
      result = model_error_messages(mock_model(errors: 0))
      expect(result).to eql('')
    end

    context 'with default configuration' do
      it 'renders correctly with one error' do
        result = model_error_messages(mock_model(errors: 1))
        expect(result).to eql(
          '<div class="alert alert-danger model-error-messages">' \
          '<p>Title is missing</p>' \
          '</div>'
        )
      end

      it 'renders correctly with two errors' do
        result = model_error_messages(mock_model(errors: 2))
        expect(result).to eql(
          '<div class="alert alert-danger model-error-messages">' \
          '<ul><li>Please select an author</li>' \
          '<li>Content is missing</li></ul>' \
          '</div>'
        )
      end
    end

    context 'with a custom configuration' do
      let(:configuration) { ModelErrorMessages.configuration }
      let(:options) { { single_error_in_paragraph: false } }
      let(:result) { model_error_messages(mock_model(errors: 1), options) }

      before do
        configuration.prepend_html = lambda do |m|
          if m.errors.full_messages.count == 1
            content_tag(:h1, 'An error occurred')
          else
            content_tag(:h1, 'Several errors occurred')
          end
        end

        configuration.append_html = lambda do |_m|
          content_tag(:p, 'Please try again.')
        end

        configuration.classes = lambda do |model|
          [
            model.class.model_name.param_key + '-foo',
            'bar'
          ]
        end
      end

      it 'renders correctly' do
        expect(result).to eql(
          '<div class="model-foo bar">' \
          '<h1>An error occurred</h1>' \
          '<ul><li>Title is missing</li></ul>' \
          '<p>Please try again.</p>' \
          '</div>'
        )
      end
    end
  end
end
