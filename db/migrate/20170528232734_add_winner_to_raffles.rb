class AddWinnerToRaffles < ActiveRecord::Migration[5.0]
  def change
  	add_column :raffles, :winner_id, :integer
  end
end
