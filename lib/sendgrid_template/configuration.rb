module SendgridTemplate
  class Configuration
    # API_URL = 'https://api.sendgrid.com'
    API_URL = 'https://sendgrid.com'
    attr_accessor :login, :password

    def initialize(options = {})
      @login = options[:login] if options.key?(:login)
      @password = options[:password] if options.key?(:password)
    end

    def connect
      @conn ||= Faraday.new(url: API_URL) do |h|
        h.headers[:content_type] = "application/json"
        h.adapter(Faraday.default_adapter)
        # h.request  :logger
        h.response :logger
        # h.response :json
      end
      @conn.basic_auth(login, password)
      @conn
    end
  end
end
