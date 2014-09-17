require "spec_helper"

describe SendgridTemplate do
  describe '.configure' do
    before do
      SendgridTemplate.configure do |config|
        config.login = 'test'
        config.password = 'testpass'
      end
    end

  end

end
