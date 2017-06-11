class DropTableSorteos < ActiveRecord::Migration[5.0]
  def change
    drop_table :sorteos
  end
end
