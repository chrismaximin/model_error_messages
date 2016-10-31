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
  when 1 then ['Title is -> missing']
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
  describe '#model_error_messages' do
    include ModelErrorMessages::Helpers

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
          '<p>Title is -&gt; missing</p>' \
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

      it 'returns a safe string' do
        result = model_error_messages(mock_model(errors: 1))
        expect(result.html_safe?).to eql(true)
      end
    end

    context 'with a custom configuration' do
      let(:configuration) { ModelErrorMessages.configuration }
      let(:options) { { single_error_in_paragraph: false } }
      let(:model) { mock_model(errors: 1) }
      let(:result) { model_error_messages(model, options) }

      before do
        configuration.prepend_html = '<h1>An error occurred</h1>'
        configuration.append_html = '<p>Please try again.</p>'
        configuration.classes = model.class.model_name.param_key + '-foo bar'
      end

      it 'renders correctly' do
        expect(result).to eql(
          '<div class="model-foo bar">' \
          '<h1>An error occurred</h1>' \
          '<ul><li>Title is -&gt; missing</li></ul>' \
          '<p>Please try again.</p>' \
          '</div>'
        )
      end
    end
  end
end
