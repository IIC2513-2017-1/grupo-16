class CreateParticipates < ActiveRecord::Migration
  def change
    create_table :participates do |t|

      t.timestamps null: false
    end
  end
end
