class RenameDaysOffColumnFromUsersTable < ActiveRecord::Migration
  def change
    rename_column :users, :days_off_per_year, :vacations_per_year
  end
end
