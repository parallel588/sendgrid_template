# frozen_string_literal: true

require 'faraday'
require 'multi_json'
require 'sendgrid_template/version'
require 'sendgrid_template/configuration'
require 'sendgrid_template/template'

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
