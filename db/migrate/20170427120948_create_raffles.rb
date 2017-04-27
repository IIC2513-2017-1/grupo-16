class CreateRaffles < ActiveRecord::Migration
  def change
    create_table :raffles do |t|

      t.timestamps null: false
    end
  end
end
