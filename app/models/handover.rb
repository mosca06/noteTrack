class Handover < ApplicationRecord
  enum :start_state, { start_disponível: 0, start_emprestado: 1, start_indisponível: 2 }
  enum :final_state, { final_disponível: 0, final_emprestado: 1, final_indisponível: 2 }

  belongs_to :client
  belongs_to :notebook

  def returned?
    final_state.present?
  end
end
