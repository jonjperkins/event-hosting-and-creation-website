class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.integer :attended_event_id
      t.integer :guest_id

      t.timestamps null: false
    end
  end
end
