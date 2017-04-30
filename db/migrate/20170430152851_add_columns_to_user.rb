class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_index :users, :email
    add_column :users, :fisrt_name, :string
    add_column :users, :last_name, :string
    add_column :users, :password, :string
  end
end
