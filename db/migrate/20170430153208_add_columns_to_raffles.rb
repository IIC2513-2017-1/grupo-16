class AddColumnsToRaffles < ActiveRecord::Migration
  def change
    add_column :raffles, :name, :string
    add_column :raffles, :prize, :string
    add_column :raffles, :price, :integer
    add_column :raffles, :finish_date, :datetime
    add_reference :raffles, :user, index: true
    add_foreign_key :raffles, :users
  end
end
