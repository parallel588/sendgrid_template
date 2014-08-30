module SendgridTemplate
  class Template < Struct.new(:id, :name, :versions)

    def initialize(attrs = {})
      super(attrs['id'],attrs['name'], attrs['versions'].map{ |j| Version.new(j) })
    end
  end
end
