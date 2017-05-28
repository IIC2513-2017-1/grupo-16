class AddImageToRaffles < ActiveRecord::Migration[5.0]
  def change
    add_column :raffles, :image, :string
  end
end
