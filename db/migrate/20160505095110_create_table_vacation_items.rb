class CreateTableVacationItems < ActiveRecord::Migration
  def change
    create_table :vacation_items do |t|
      t.integer :vacation_id
      t.date :vacation_date
    end
  end
end
