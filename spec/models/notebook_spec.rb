require 'rails_helper'

RSpec.describe Notebook, type: :model do
  subject { build(:notebook) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:brand) }
    it { is_expected.to validate_presence_of(:model) }
    it { is_expected.to validate_presence_of(:asset_number) }
    it { is_expected.to validate_presence_of(:serial_number) }
    it { is_expected.to validate_presence_of(:equipment_id) }
    it { is_expected.to validate_presence_of(:purchase_date) }

    context 'when testing uniqueness' do
      before { create(:notebook) }

      it { is_expected.to validate_uniqueness_of(:asset_number) }
      it { is_expected.to validate_uniqueness_of(:serial_number) }
      it { is_expected.to validate_uniqueness_of(:equipment_id) }
    end
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:state).with_values(disponível: 0, emprestado: 1, indisponível: 2) }
  end
end
