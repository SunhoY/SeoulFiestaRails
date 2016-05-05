class AddColumnsToVacations < ActiveRecord::Migration
  def change
    add_column :vacations, :vacation_status, :string
  end
end
