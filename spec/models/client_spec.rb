require 'rails_helper'

RSpec.describe Client, type: :model do
  subject { build(:client) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:sector) }
  end

  describe 'enums' do
    it {
      is_expected.to define_enum_for(:status).with_values(
        { sem_notebook: 0, utilizando_notebook: 1 }
      )
    }
  end
end
