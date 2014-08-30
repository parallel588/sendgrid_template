require "faraday"
require 'faraday_middleware'
require "sendgrid_template/version"
require "sendgrid_template/configuration"
require "sendgrid_template/templates"
require "sendgrid_template/template"

module SendgridTemplate

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end

SendgridTemplate.configure do |config|
  config.login =  'luxfix'
  config.password =  'Valent1n0'
end
