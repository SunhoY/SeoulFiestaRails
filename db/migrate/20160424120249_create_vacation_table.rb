class CreateVacationTable < ActiveRecord::Migration
  def change
    create_table :vacation_tables do |t|
      t.integer :user_id
      t.string :type
      t.date :start_date
      t.date :end_date
      t.string :reason
    end
  end
end
