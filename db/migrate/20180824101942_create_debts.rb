class CreateDebts < ActiveRecord::Migration[5.2]
  def change
    create_table :debts do |t|
      t.references :bill, foreign_key: true
      t.references :user, foreign_key: true
      t.decimal :amount, precision: 8, scale: 2, default: 0
      t.boolean :status
    end
  end
end
