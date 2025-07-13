class CreateNotebooks < ActiveRecord::Migration[7.0]
  def change
    create_table :notebooks do |t|
      t.string :brand, null: false
      t.string :model, null: false
      t.string :asset_number, null: false, index: { unique: true }
      t.string :serial_number, null: false, index: { unique: true }
      t.string :equipment_id, null: false, index: { unique: true }
      t.date :purchase_date, null: false
      t.date :manufacture_date
      t.text :description
      t.integer :state, default: 0, null: false

      t.timestamps
    end
  end
end