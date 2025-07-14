class Client < ApplicationRecord
  enum :status, { sem_notebook: 0, utilizando_notebook: 1 }

  validates :name, :sector, presence: true

  after_initialize :set_default_status, if: :new_record?

  private

  def set_default_status
    self.status ||= :sem_notebook
  end
end
