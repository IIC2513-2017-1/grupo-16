class AddConfirmToParticipates < ActiveRecord::Migration[5.0]
  def change
  	add_column :participates, :confirmed, :boolean
  end
end
