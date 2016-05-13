class AddHostIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :host_id, :integer
  end
end
