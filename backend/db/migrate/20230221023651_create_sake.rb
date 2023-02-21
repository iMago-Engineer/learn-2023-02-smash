class CreateSake < ActiveRecord::Migration[7.0]
  def change
    create_table :sakes do |t|
      t.string :name, null: false, unique: true
      t.integer :ratio, null: false
      t.timestamps
    end
  end
end
