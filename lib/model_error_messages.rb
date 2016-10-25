%w(
  configuration
  version
).each do |file_name|
  require File.join(File.dirname(__FILE__), 'model_error_messages', file_name)
end
