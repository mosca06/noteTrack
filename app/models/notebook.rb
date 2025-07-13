class Notebook < ApplicationRecord
  enum :state, { :disponível => 0, :emprestado => 1, :indisponível => 2 }

  validates :brand, :model, :asset_number, :serial_number, :equipment_id, :purchase_date, presence: true
  validates :asset_number, :serial_number, :equipment_id, uniqueness: true
end
