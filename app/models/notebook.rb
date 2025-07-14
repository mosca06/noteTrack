class Notebook < ApplicationRecord
  enum :state, { disponível: 0, emprestado: 1, indisponível: 2 }

  has_one_attached :pdf
  has_many :handovers, dependent: :nullify
  has_many :clients, through: :handovers

  validates :brand, :model, :asset_number, :serial_number, :equipment_id, :purchase_date, presence: true
  validates :asset_number, :serial_number, :equipment_id, uniqueness: true

  after_initialize :set_default_status, if: :new_record?

  def pode_ser_excluido?
    disponível? && handovers.empty?
  end

  private

  def set_default_status
    self.state ||= :disponível
  end
end
