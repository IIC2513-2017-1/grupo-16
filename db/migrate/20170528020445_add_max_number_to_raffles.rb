class AddMaxNumberToRaffles < ActiveRecord::Migration[5.0]
  def change
    add_column :raffles, :max_number, :integer
  end
end
