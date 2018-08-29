class AddTimestampsToBill < ActiveRecord::Migration[5.2]
  def change
    add_column :bills, :created_at, :datetime
    add_column :bills, :updated_at, :datetime
  end
end
