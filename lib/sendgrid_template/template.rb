module SendgridTemplate
  class Template < Struct.new(:id, :name, :versions)
    def initialize(attrs = {})
      super(
        attrs['id'],
        attrs['name'],
        attrs['versions'].map { |j| Version.new(j) }
      )
    end

    def attributes
      Hash[each_pair.to_a]
    end

    def attributes=(attrs)
      attrs.each do |k, v|
        self[k.to_sym] = v if respond_to?(k)
      end
    end

    def save
      id.nil? ? create : update
    end

    def update
      response = SendgridTemplate.configuration.connect.patch("/v3/templates/#{id}") do |req|
        req.headers[:content_type] = 'application/json'
        req.body = MultiJson.dump(attributes.reject{ |k, v| v.nil? || k.to_s[/id|_id\Z/] })
      end

      if response.success?
        self.attributes = response.body
      else
        nil
      end
    end

    def create
      # create
      response = SendgridTemplate.configuration.connect.post("/v3/templates/") do |req|
        req.headers[:content_type] = 'application/json'
        req.body = MultiJson.dump(attributes.reject{ |k, v| v.nil? || k.to_s[/id|_id\Z/]  })
      end
      if response.success?
        self.attributes = response.body
      else
        nil
      end
    end

    def delete(force = false)
      if versions.empty?
        SendgridTemplate.configuration.connect.delete("/v3/templates/#{id}").success?
      else
        return false unless force
        self.versions.each(&:delete)
        self.versions = []
        delete
      end
    end

    class << self
      def all(connect: nil, opts: {})
        conn = connect || SendgridTemplate.configuration.connect
        req_opts = {
          page_size: 200,
          generations: 'legacy,dynamic'
        }.merge(opts)

        resp = MultiJson.load(
          conn.get('/v3/templates', req_opts).body
        )
        resp['result'].map do |attrs|
          Template.new(attrs)
        end
      end

      def find(template_id, connect: nil)
        conn = connect || SendgridTemplate.configuration.connect
        response = conn.get("/v3/templates/#{template_id}")
        if response.success?
          Template.new(MultiJson.load(response.body))
        else
          # raise
        end
      end

    end
  end
end
