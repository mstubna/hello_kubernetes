require 'rails_helper'

RSpec.describe Widget, type: :model do
  describe 'schema' do
    describe 'columns' do
      it { is_expected.to have_db_column(:name).of_type(:string) }
    end
  end

  describe 'validations' do
    subject { FactoryBot.create(:widget) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end
