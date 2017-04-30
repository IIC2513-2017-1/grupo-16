class AddColumsToParticipates < ActiveRecord::Migration
  def change
    add_reference :participates, :user, index: true
    add_foreign_key :participates, :users
    add_reference :participates, :raffle, index: true
    add_foreign_key :participates, :raffles
  end
end
