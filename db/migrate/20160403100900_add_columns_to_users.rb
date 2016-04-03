class AddColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :rank, :string
    add_column :users, :department, :string
  end
end
