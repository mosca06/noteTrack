class CreateClients < ActiveRecord::Migration[7.2]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :sector
      t.integer :status

      t.timestamps
    end
  end
end
