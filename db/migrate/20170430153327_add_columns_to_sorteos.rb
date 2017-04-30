class AddColumnsToSorteos < ActiveRecord::Migration
  def change
    add_reference :sorteos, :user, index: true
    add_foreign_key :sorteos, :users
    add_reference :sorteos, :raffle, index: true
    add_foreign_key :sorteos, :raffles
  end
end
