class AddNumberToParticipates < ActiveRecord::Migration[5.0]
  def change
    add_column :participates, :number, :integer
  end
end
