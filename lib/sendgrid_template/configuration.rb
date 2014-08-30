module SendgridTemplate
  class Configuration
    attr_accessor :login, :password
    attr_reader :api_url

    def initialize
      @api_url = 'https://api.sendgrid.com'
    end

    def connect
      @conn ||= Faraday.new(url: api_url) do |h|
        h.headers[:content_type] = "application/json"
        h.adapter(Faraday.default_adapter)
        h.response :json
      end
      @conn.basic_auth(login, password)
      @conn
    end
  end
end
