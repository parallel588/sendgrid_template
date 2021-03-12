module SendgridTemplate
  class Configuration
    API_URL = 'https://api.sendgrid.com'
    attr_accessor :api_key

    def initialize(options = {})
      @api_key = options[:api_key]
    end

    def connect
      @conn ||= Faraday.new(url: API_URL) do |h|
        h.headers[:content_type] = 'application/json'
        h.adapter(Faraday.default_adapter)
      end

      @conn.authorization :Bearer, @api_key
      @conn
    end
  end
end
