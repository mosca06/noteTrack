class CreateHandovers < ActiveRecord::Migration[7.2]
  def change
    create_table :handovers do |t|
      t.references :client, null: false, foreign_key: true
      t.references :notebook, null: false, foreign_key: true
      t.integer :start_state, null: false
      t.integer :final_state
      t.datetime :start_date, null: false
      t.datetime :final_date
      t.text :cause

      t.timestamps
    end
  end
end
