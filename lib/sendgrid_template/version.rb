# frozen_string_literal: true

module SendgridTemplate
  VERSION = '0.0.5'

  Version = Struct.new(:id, :template_id,
                       :active, :name, :subject, :updated_at,
                       :html_content, :plain_content, :user_id,
                       :generate_plain_content,
                       :editor,
                       :thumbnail_url) do
    def initialize(attrs = {})
      super(attrs['id'],
            attrs['template_id'],
            attrs['active'],
            attrs['name'],
            attrs['subject'],
            attrs['updated_at'],
            attrs['html_content'],
            attrs['plain_content'],
            attrs['user_id'],
            attrs['generate_plain_content'],
            attrs['editor'],
            attrs['thumbnail_url']
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
      if id.nil?
        create
      else
        update
      end
    end

    def update
      # update
      response = SendgridTemplate.configuration.connect.patch("/v3/templates/#{v.template_id}/versions/#{v.id}") do |req|
        req.headers[:content_type] = 'application/json'
        req.body = JSON.generate(v.attributes.reject { |k, v| v.nil? || k.to_s[/id|_id\Z/] })
      end
      self.attributes = response.body if response.success?
    end

    def create
      # create
      response = SendgridTemplate.configuration.connect.post("/v3/templates/#{template_id}/versions") do |req|
        req.headers[:content_type] = 'application/json'
        req.body = JSON.generate(attributes.reject { |k, v| v.nil? || k.to_s[/id|_id\Z/] })
      end
      self.attributes = response.body if response.success?
    end

    def delete
      SendgridTemplate.configuration.connect.delete("/v3/templates/#{template_id}/versions/#{id}").success?
    end

    class << self
      def find(template_id, _version_id)
        response = SendgridTemplate.configuration.connect.get("/v3/templates/#{template_id}/versions/#{id}")
        new(response.body) if response.success?
      end

      def activate(template_id, _version_id)
        response = SendgridTemplate.configuration.connect.get("/v3/templates/#{template_id}/versions/#{id}/activate")
        new(response.body) if response.success?
      end
    end
  end
end
