require 'spec_helper'

describe 'ModelErrorMessages::Configuration' do
  let(:klass) { ModelErrorMessages }
  subject { klass.configuration }

  it 'can be set by a block' do
    klass.configure do |config|
      config.single_error_in_paragraph = 'test'
    end

    expect(subject.single_error_in_paragraph).to eql('test')
  end

  it 'can be set individually' do
    subject.single_error_in_paragraph = 'test'
    expect(subject.single_error_in_paragraph).to eql('test')
  end

  it 'can be resetted' do
    subject.single_error_in_paragraph = 'test'
    expect(subject.single_error_in_paragraph).to eql('test')

    subject.reset

    expect(subject.single_error_in_paragraph).not_to eql('test')
  end
end
