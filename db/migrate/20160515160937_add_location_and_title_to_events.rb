class AddLocationAndTitleToEvents < ActiveRecord::Migration
  def change
    add_column :events, :location, :string
    add_column :events, :title, :string
  end
end
