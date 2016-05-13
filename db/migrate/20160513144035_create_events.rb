class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string 
      t.date :event_date
      t.time :event_time
      t.string :description
      
      t.timestamps null: false
    end
  end
end

