require 'simplecov'
SimpleCov.start do
  add_filter '/spec'
end

require_relative '../log_parser/env'
require 'faker'
