class ChangeVacationTableName < ActiveRecord::Migration
  def change
    rename_table :vacation_tables, :vacations
  end
end
