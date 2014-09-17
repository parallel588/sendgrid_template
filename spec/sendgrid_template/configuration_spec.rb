require "spec_helper"

module SendgridTemplate
  describe Configuration do
    subject { Configuration.new(login: 'test', password: 'test') }
    describe '#connect' do
      it 'should return connect' do
        expect(subject.connect.class).to eq(Faraday::Connection)
      end
    end
  end
end
