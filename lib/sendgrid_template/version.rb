module SendgridTemplate
  VERSION = "0.0.1"

  class Version < Struct.new(:id, :template_id, :active, :name, :subject, :updated_at)
    def initialize(attrs = {})
      super(attrs['id'], attrs['template_id'], attrs['active'], attrs['name'], attrs['subject'],attrs['updated_at'])
    end
  end
end
