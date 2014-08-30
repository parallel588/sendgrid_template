module SendgridTemplate
  class Templates

    class << self
      def all
        SendgridTemplate.configuration.connect.get("/v3/templates").body['templates'].map do |attrs|
          Template.new(attrs)
        end
      end
    end
  end
end
