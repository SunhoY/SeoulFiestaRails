class RemoveColumnsFromVacations < ActiveRecord::Migration
  def change
    remove_columns :vacations, :start_date, :end_date
  end
end
