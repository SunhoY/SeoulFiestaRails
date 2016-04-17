class ChangeColumnNameDayOffPerYearToDaysOffPerYear < ActiveRecord::Migration
  def change
    rename_column :users, :day_off_per_year, :days_off_per_year
  end
end
