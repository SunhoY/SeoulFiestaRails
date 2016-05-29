class CreateTableSession < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.belongs_to :user
      t.string :token
    end
  end
end
