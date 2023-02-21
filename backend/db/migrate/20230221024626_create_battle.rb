class CreateBattle < ActiveRecord::Migration[7.0]
  def change
    create_table :battles do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :rank, null: false
      t.integer :scene, null: false
      t.references :sake, null: false, foreign_key: true
      t.integer :amount, null: false
      t.timestamps
    end
  end
end
