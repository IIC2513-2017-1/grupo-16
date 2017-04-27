class CreateSorteos < ActiveRecord::Migration
  def change
    create_table :sorteos do |t|

      t.timestamps null: false
    end
  end
end
