class AddColumnDayOffPerYear < ActiveRecord::Migration
  def change
    add_column :users, :day_off_per_year, :integer
  end
end
